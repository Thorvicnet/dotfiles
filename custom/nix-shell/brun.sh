#!/bin/bash

nix-bin-of() {
  local pkg="$1"
  if ! nix-shell -p "$pkg" --run "command -v $pkg" >/dev/null 2>&1; then
    case "$pkg" in
    *-bin) pkg="${pkg%-bin}" ;;
    esac
  fi
  nix-shell -p "$pkg" --run "command -v ${pkg##*/}"
}

# `brun` runs an application in a restrictive bubblewrap sandbox.
#
# Usage:
#   brun [flags] <app> [args...]
#     - Runs the specified application in a sandbox.
#
#   brun [flags] cli <app> [command...]
#     - Launches a sandboxed zsh shell.
#     - If [command...] is provided, it's executed in the shell.
#
# Fallback Behavior:
# If the binary for <app> cannot be found, it automatically launches a CLI.
#
# Flags:
#   --net:  Enable networking (disabled by default).
#   --full: Provide more complete read-only binds for /usr, /etc, /lib, /bin.
#   --mnt:  Bind the current directory to ~/mnt inside the sandbox.
brun() {
  local net=0 full=0 mnt=0
  # parse optional flags
  while [ $# -gt 0 ]; do
    case "$1" in
    --net)
      net=1
      shift
      ;;
    --full)
      full=1
      shift
      ;;
    --mnt)
      mnt=1
      shift
      ;;
    *) break ;;
    esac
  done

  # mode selection: cli or single app
  local mode_cli=0
  local -a clipkgs=()
  if [ "${1:-}" = "cli" ]; then
    mode_cli=1
    shift
    # every following token is a package to expose in the sandboxed shell
    while [ $# -gt 0 ]; do
      clipkgs+=("$1")
      shift
    done
  fi

  # resolve target binary or fallback to cli
  local app bin
  if [ "$mode_cli" -eq 0 ]; then
    app="$1"
    shift
    if ! bin="$(nix-bin-of "$app")"; then
      mode_cli=1
      clipkgs=("$app")
    fi
  fi

  local args=(
    --unshare-user-try --unshare-ipc --unshare-pid --unshare-uts --unshare-cgroup-try
    --new-session --die-with-parent
    --proc /proc --dev /dev
    --ro-bind /nix /nix
    --tmpfs /home --dir "/home/$USER" --setenv HOME "/home/$USER"
    --tmpfs /tmp
    --tmpfs "$XDG_RUNTIME_DIR"
    --bind "$XDG_RUNTIME_DIR/wayland-0" "$XDG_RUNTIME_DIR/wayland-0"
    --bind "$XDG_RUNTIME_DIR/bus" "$XDG_RUNTIME_DIR/bus"
    --setenv XDG_RUNTIME_DIR "$XDG_RUNTIME_DIR"
    --setenv WAYLAND_DISPLAY "${WAYLAND_DISPLAY:-wayland-0}"
    --setenv XDG_SESSION_TYPE wayland
    --setenv XDG_CURRENT_DESKTOP dwl
    --setenv MOZ_ENABLE_WAYLAND 1
    --setenv QT_QPA_PLATFORM wayland
    --setenv SDL_VIDEODRIVER wayland
    --setenv GDK_BACKEND wayland
    --chdir "/home/$USER"
    --dev-bind /dev/dri /dev/dri
    --ro-bind /etc/passwd /etc/passwd
    --ro-bind /etc/group /etc/group
    --ro-bind /usr/share/fonts /usr/share/fonts
    --ro-bind /etc/fonts /etc/fonts
    --ro-bind /usr/share/fontconfig /usr/share/fontconfig
    --ro-bind /etc/ssl /etc/ssl
    --ro-bind /usr/share/ca-certificates /usr/share/ca-certificates
  )

  if [ "$full" -eq 1 ]; then
    # Read-only binds /usr, /etc, /bin, /lib directly
    args+=(
      --ro-bind /usr /usr
      --ro-bind /etc /etc
      --ro-bind /bin /bin
      --ro-bind /lib /lib
    )
  fi

  if [ "$mnt" -eq 1 ]; then
    # Bind current directory into sandboxed home under ~/mnt
    args+=(
      --bind "$PWD" "/home/$USER/mnt"
    )
  fi

  if [ "$net" -eq 0 ]; then
    args+=(--unshare-net) # no network (default)
  else
    args+=(--ro-bind /etc/resolv.conf /etc/resolv.conf
      --ro-bind /etc/hosts /etc/hosts)
  fi

  if [ "$mode_cli" -eq 1 ]; then
    # Build PATH with all /nix/.../bin for listed packages/commands
    local -a path_dirs=()
    declare -A seen=()
    for p in "${clipkgs[@]}"; do
      if d="$(nix-bin-of "$p" 2>/dev/null)"; then
        d="$(dirname "$d")"
        if [ -n "${seen[$d]:-}" ]; then continue; fi
        seen[$d]=1
        path_dirs+=("$d")
      fi
    done

    args+=(
      --dir /bin
      --ro-bind /bin/zsh /bin/zsh # Surface could be reduced (ldd /bin/zsh)
      --ro-bind /lib64 /lib64
      --ro-bind /usr/lib /usr/lib
    )

    local path_join
    path_join="$(
      IFS=:
      echo "${path_dirs[*]}"
    )"
    if [ -n "$path_join" ]; then
      args+=(--setenv PATH "$path_join:/usr/bin:/bin")
    else
      args+=(--setenv PATH "/usr/bin:/bin")
    fi
    bwrap "${args[@]}" /bin/zsh -f
  else
    bwrap "${args[@]}" "$bin" "$@"
  fi
}
