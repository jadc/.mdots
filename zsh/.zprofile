# Start X
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ] && [ ! -f "$HOME/.nox" ]; then
  exec startx > /dev/null 2>&1
fi
