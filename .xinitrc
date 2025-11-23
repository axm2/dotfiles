# Start D-Bus session and export its env vars
eval "$(dbus-launch --sh-syntax --exit-with-session)"

[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

light -S 40 &
redshift -l 40.7221:-73.7613 -t 6500:2500 &
compton --conf ~/.config/compton/compton.conf -b &
sxhkd &

xset +fp "$HOME/.fonts"
xset fp rehash

exec bspwm
