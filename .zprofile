export XKB_DEFAULT_LAYOUT=fr
# export WLR_RENDER_NO_EXPLICIT_SYNC=1 # To fix flickering in zed
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec /home/thorvicnet/.config/suckless/start.sh
