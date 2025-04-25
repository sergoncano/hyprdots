echo "This installer will prompt you to choose which features of the hyprdots you want installed on your system. 
Please read the code carefully before executing with elevated privileges."
echo 


if [[ $(whoami) =~ "root" ]]; then

cd $(dirname "$0")

HOMEDIR=$(getent passwd $SUDO_USER | cut -d: -f6)

pacman -Sy

read -p "Do you want the general hyprland config installed?[Y/n]" hyprland
if [[ $hyprland =~ [Yy]$ ]]; then

	# For unit file management
	pacman -S --needed uwsm

	# For audio control
	pacman -S --needed pamixer pipewire-alsa wireplumber pipewire-pulse
	systemctl --user --now enable pipewire pipewire-pulse wireplumber
	
	pacman -S --needed python-pywal
	echo "!!! THE PYWAL BROWSER EXTENSION MUST BE INSTALLED MANUALLY !!!"
	echo "I recommand setting 'Background extra' to the first color of the second row in the pywal config aswell"
	

	read -p "Do you want the dunst color scheme to change?[Y/n]" dunst
	if [[ $dunst =~ [Yy]$ ]]; then
		mv $HOMEDIR/.config/dunst/dunstrc $HOMEDIR/.config/dunst/dunstrc.backup
		ln -s $HOMEDIR/hyprdots/dunstrc $HOMEDIR/.config/dunst/dunstrc
	fi
	# For certain menus
	pacman -S --needed rofi-wayland
	mkdir $HOMEDIR/.config/rofi
	mv $HOMEDIR/.config/rofi/config.rasi $HOMEDIR/.config/rofi/config.rasi.backup
	ln -s $HOMEDIR/hyprdots/rofi/config.rasi $HOMEDIR/.config/rofi/
	ln -s $HOMEDIR/hyprdots/rofi/launchpad.rasi $HOMEDIR/.config/rofi/
	ln -s $HOMEDIR/hyprdots/rofi/hiddenFiles.rasi $HOMEDIR/.config/rofi/
	ln -s $HOMEDIR/hyprdots/rofi/wallpaperPicker.rasi $HOMEDIR/.config/rofi/
	mv $HOMEDIR/.config/wal/templates/colors-rofi-light.rasi $HOMEDIR/.config/wal/templates/colors-rofi-light.rasi.backup
	ln -s $HOMEDIR/hyprdots/rofi/templates/colors-rofi-light.rasi $HOMEDIR/.config/templates/

	# For screenshotting
    
	read -p "Do you want software for screenshotting? yay will be installed if it is not already present[Y/n]" screenshots
	if [[ $screenshots =~ [Yy]$ ]]; then
        pacman -S --needed hyprpicker 
		pacman -S --needed yay
        yay -Sc hyprshot
    fi
	# For playing media
	pacman -S --needed playerctl
	
	# Wallpaper
	pacman -S --needed swww

	read -p "Do you want widgets installed? yay will be installed if it is not already present[Y/n]" eww
	if [[ $eww =~ [Yy]$ ]]; then
		# Widgets 
		pacman -S --needed yay
		yay -Sc eww
		mkdir $HOMEDIR/.config/eww
		mv $HOMEDIR/.config/eww/eww.yuck $HOMEDIR/.config/eww/eww.yuck.backup
		mv $HOMEDIR/.config/eww/eww.scss $HOMEDIR/.config/eww/eww.scss.backup
		ln -s $HOMEDIR/hyprdots/eww/eww.yuck $HOMEDIR/.config/eww/
		ln -s $HOMEDIR/hyprdots/eww/eww.scss $HOMEDIR/.config/eww/
		for d in eww/*/; do
			mkdir $HOMEDIR/.config/eww/$d
			ln -s $HOMEDIR/hyprdots/eww/$d.yuck $HOMEDIR/.config/eww/$d/
			ln -s $HOMEDIR/hyprdots/eww/$d.scss $HOMEDIR/.config/eww/$d/
		done
	fi

	ln -s $HOMEDIR/hyprdots/scripts/changeWallpaper /usr/local/bin/
	ln -s $HOMEDIR/hyprdots/scripts/toggleWaybar  /usr/local/bin/
	mkdir $HOMEDIR/.config/hypr/
	mv $HOMEDIR/.config/hypr/hyprland.conf $HOMEDIR/.config/hypr/hyprland.conf.backup
	ln -s $HOMEDIR/hyprdots/hypr/hyprland.conf $HOMEDIR/.config/hypr/
	    
    echo "What keyboard layout do you wish to use?"
    read -p "Mind capital letters, if you mispell it you might have a hard time reconfiguring it." layout
    sed -i --follow-symlinks "s|kb_layout = es|kb_layout = $layout|" $HOMEDIR/hyprdots/hypr/hyprland.conf


    hyprctl reload
fi

echo

read -p "Do you want the hyprlock/hypridle config installed?[Y/n]" hyprlock
if [[ $hyprlock =~ [Yy]$ ]]; then
	pacman -S --needed hypridle hyprlock
	mkdir $HOMEDIR/.config/hypr/
	mv $HOMEDIR/.config/hypr/hyprlock.conf $HOMEDIR/.config/hypr/hyprlock.conf.backup
	mv $HOMEDIR/.config/hypr/hypridle.conf $HOMEDIR/.config/hypr/hypridle.conf.backup
	ln -s $HOMEDIR/hyprdots/hypr/hyprlock.conf $HOMEDIR/.config/hypr/
	ln -s $HOMEDIR/hyprdots/hypr/hypridle.conf $HOMEDIR/.config/hypr/
	cp $HOMEDIR/hyprdots/assets/"The Wild Breath of Zelda.otf" $HOMEDIR/.local/share/fonts/
    mkdir $HOMEDIR/Pictures/
    mkdir $HOMEDIR/Pictures/walllpapers/
	ln -s $HOMEDIR/hyprdots/assets/lockscreen.jpg $HOMEDIR/Pictures/wallpapers/
    systemctl --user enable --now hypridle
fi

echo

read -p "Do you want the kitty config installed?[Y/n]" kitty
if [[ $kitty =~ [Yy]$ ]]; then
	mkdir $HOMEDIR/.config/kitty/
	mv $HOMEDIR/.config/kitty/kitty.conf $HOMEDIR/.config/kitty/kitty.conf.backup
	ln -s $HOMEDIR/hyprdots/kitty/kitty.conf $HOMEDIR/.config/kitty/
fi

echo

read -p "Do you want the waybar config installed?[Y/n]" waybar
if [[ $waybar =~ [Yy]$ ]]; then
	pacman -S --needed waybar ttf-font-awesome
	mkdir $HOMEDIR/.config/waybar
	mv $HOMEDIR/.config/waybar/config.jsonc $HOMEDIR/.config/waybar/config.jsonc.backup
	mv $HOMEDIR/.config/waybar/style.css $HOMEDIR/.config/waybar/style.css.backup
	ln -s $HOMEDIR/hyprdots/waybar/config.jsonc $HOMEDIR/.config/waybar/
	ln -s $HOMEDIR/hyprdots/waybar/style.css $HOMEDIR/.config/waybar/
    sed -i --follow-symlinks "s|/home/sergio/hyprdots/waybar/republicLogo.png|$HOMEDIR/hyprdots/waybar/republicLogo.png|"
fi

read -p "Do you want the bash config installed?[Y/n]" bashconf 
if [[ $bashconf =~ [Yy]$ ]]; then
	mv $HOMEDIR/.bashrc $HOMEDIR/.bashrc.backup
	ln -s $HOMEDIR/hyprdots/.bashrc $HOMEDIR/.bashrc
fi
hyprctl reload
else
    echo "This script must be run as root!"
fi
