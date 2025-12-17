HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
bindkey "^?" backward-delete-char # fix vi mode else
zstyle :compinstall filename '/home/thorvicnet/.zshrc'

autoload -Uz compinit # compinit is slow
compinit

export EDITOR="nvim"

alias nv="nvim"
alias snv="sudo nvim"
alias la="ls -lah --classify --color"

alias prux="paru --sudoflags '-E'"
alias colloscope="pdf ~/Documents/ColloscopeMP\&I2526version1809.pdf"

alias startw="~/.config/suckless/start.sh"
alias background="wbg ~/Pictures/background/wave2.png </dev/null &>/dev/null & disown"
alias lock="waylock -init-color 0x000000 -input-color 0x246076"

alias pdfs="zathura *.pdf </dev/null &>/dev/null & disown && exit"
function pdf() {
    for file in "$@"; do
        zathura "$file" </dev/null &>/dev/null & disown
    done
    exit
}
alias here="foot </dev/null &>/dev/null & disown"
alias sn="shutdown now"
alias rb="reboot"
alias hb="systemctl hibernate"
alias mute="pactl set-source-mute 1 1"
alias unmute="pactl set-source-mute 1 0"
alias bl="bluetoothctl"
alias reload="source ~/.zshrc"
alias fixkb="setxkbmap -layout fr"
alias zshconfig="nvim ~/.zshrc"
alias uuid="uuidgen"
alias \?="rax2 -r "
alias myip="curl https://ipinfo.io/ip"
alias screenwriting="gromit-mpx"
alias linpeas="curl -L https://github.com/carlospolop/PEASS-ng/releases/latest/download/linpeas.sh | sh -s"
alias towindows="sudo grub-reboot 2 && sudo reboot"
alias d="date --iso-8601=seconds"
alias oops="git add . && git commit --amend --no-edit && git push --force-with-lease"
alias webcam="mpv av://v4l2:/dev/video0 --profile=low-latency --untimed"

alias mirrorsgen="sudo ghostmirror -PoclLS Belgium,Germany,France /etc/pacman.d/mirrorlist 30 state,outofdate,morerecent,ping"
alias mirrorssort="sudo ghostmirror -PmuolsS  /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist light state,outofdate,morerecent,estimated,speed"

alias nixhaskell="~/.config/custom/nix-shell/haskell.sh"
alias nixlatex="~/.config/custom/nix-shell/latex.sh"
alias nixocaml="~/.config/custom/nix-shell/ocaml.sh"
alias nixtypst="~/.config/custom/nix-shell/typst.sh"
alias nixuiua="~/.config/custom/nix-shell/uiua.sh"

alias fixscreen="wlr-randr --output HDMI-A-1 --pos 0,0 && wlr-randr --output DP-1 --pos 1920,0"

alias statusbarreload="pkill -f 'status_daemon' && (nohup ~/.config/suckless/status-daemon/status_daemon >/dev/null 2>&1 < /dev/null & )"
alias termbin='nix-shell -p netcat --run "nc termbin.com 9999"'

alias ts="tailscale"
function warp() {
    if [ "$1" = "up" ]; then
        sudo systemctl start warp-svc && sleep 1 && warp-cli connect && export WARP_UP="true" && statusbarreload
    elif [ "$1" = "down" ]; then
        warp-cli disconnect && sudo systemctl stop warp-svc && export WARP_UP="false" && statusbarreload
    else
        echo "Usage: warp <up|down>"
    fi
}
alias warpcheck="curl https://www.cloudflare.com/cdn-cgi/trace/"

alias externalscreen="xrandr --output HDMI-2 --mode 1920x1080"
function touchscreen() {
    if [ "$1" = "true" ]; then
        xinput --set-prop 'ELAN Touchscreen' 'Device Enabled' 1
    elif [ "$1" = "false" ]; then
        xinput --set-prop 'ELAN Touchscreen' 'Device Enabled' 0
    else
        echo "Usage: touchscreen <true|false>"
    fi
  }
alias nrun="nix-shell --command zsh -p"
source /home/thorvicnet/.config/custom/nix-shell/brun.sh

# SPACESHIP_PROMPT_ASYNC=true
# SPACESHIP_PROMPT_ADD_NEWLINE=true
# eval "$(starship init zsh)"
setopt promptsubst
VIMODE='[i]'
function zle-keymap-select zle-line-init {
  case $KEYMAP in
    vicmd) VIMODE='%F{green}%B[n]%b%f' ;;
    viins|main) VIMODE='[i]' ;;
  esac
  zle reset-prompt
}
zle -N zle-keymap-select
zle -N zle-line-init
PROMPT='%B%F{blue}%~%b%f '
RPROMPT='%(?..%F{red}[%?]%f | )$VIMODE | %F{white}%B%D{%H:%M:%S}%b%f'

eval "$(zoxide init zsh)"
alias cd="z"
source <(fzf --zsh)
source /home/thorvicnet/.config/zsh-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# lazydocker
# lazygit
# rg
# fd
# impala
# bluetui

alias nixclean="nix-store --gc"
alias deepclean="(yes | paru -Scc) && sudo journalctl --vacuum-time=7d && (sudo pacman -Qdtq | sudo pacman -Rns -)"
alias fullclean="deepclean && allclean"
# # Maintenance
# nix-store --gc
#
# paccache -r
#
# pacman -Qdtq | pacman -Rns -
# pacman -Qei | awk '/^Name/{name=$3} /^Installed Size/{print $4$5, name}' | sort -h
#
# journalctl --disk-usage
# sudo journalctl --vacuum-time=7d
#
# sudo du -sh ~/.cache
# rm -rf ~/.cache/*
#
# paru -Syu
# nix-channel --update

# # Needs fortune-mod and cowsay
# if [ -x /usr/bin/fortune -a -x /usr/bin/cowsay ]; then
#   echo $(fortune science)
# 	fortune science | cowsay -r
# fi

# xfreerdp /v:100.126.107.18 /f /dynamic-resolution /clipboard /sound # To connect to remote desktop

# nix under proxy:
# sudo systemctl edit nix-daemon 
# 
# [Service]
# Environment="http_proxy=http://10.0.0.1:3128"
# Environment="https_proxy=http://10.0.0.1:3128"
#
# sudo systemctl restart nix-daemon

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /home/thorvicnet/.dart-cli-completion/zsh-config.zsh ]] && . /home/thorvicnet/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]

