#!/bin/bash
set -euo pipefail

PROXY="http://10.0.0.1:3128/"
ENV_DIR="$HOME/.config/environment.d"
ENV_FILE="$ENV_DIR/99-proxy.conf"

apply_proxy() {
  mkdir -p "$ENV_DIR"
  cat >"$ENV_FILE" <<EOF
http_proxy=$PROXY
https_proxy=$PROXY
HTTP_PROXY=$PROXY
HTTPS_PROXY=$PROXY
EOF
  systemctl --user import-environment http_proxy https_proxy HTTP_PROXY HTTPS_PROXY
  git config --global http.proxy "$PROXY" || true
  git config --global https.proxy "$PROXY" || true

  export http_proxy="$PROXY" https_proxy="$PROXY" HTTP_PROXY="$PROXY" HTTPS_PROXY="$PROXY"
  printf '%s\n' "Proxy applied. New apps you start will use it."
}

remove_proxy() {
  rm -f "$ENV_FILE"
  systemctl --user unset-environment http_proxy https_proxy HTTP_PROXY HTTPS_PROXY || true
  git config --global --unset http.proxy || true
  git config --global --unset https.proxy || true

  unset http_proxy https_proxy HTTP_PROXY HTTPS_PROXY || true
  printf '%s\n' "Proxy removed. New apps you start will not use it."
}

case "${1-}" in
on) apply_proxy ;;
off) remove_proxy ;;
*)
  echo "Usage: $0 [on|off]"
  exit 1
  ;;
esac
