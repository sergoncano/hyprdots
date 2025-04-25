echo "This installer will prompt you to choose which features of the hyprdots you want installed on your system. 
Please read the code carefully before executing with  permissions."
echo 

cd $(dirname "$0")

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
		mv ~/.config/dunst/dunstrc ~/.config/dunst/dunstrc.backup
		ln -s ~/hyprdots/dunstrc ~/.config/dunst/dunstrc
	fi
	# For certain menus
	pacman -S --needed rofi-wayland
	mkdir ~/.config/rofi
	mv ~/.config/rofi/config.rasi ~/.config/rofi/config.rasi.backup
	ln -s ~/hyprdots/rofi/config.rasi ~/.config/rofi/
	ln -s ~/hyprdots/rofi/launchpad.rasi ~/.config/rofi/
	ln -s ~/hyprdots/rofi/hiddenFiles.rasi ~/.config/rofi/
	ln -s ~/hyprdots/rofi/wallpaperPicker.rasi ~/.config/rofi/
	mv ~/.config/wal/templates/colors-rofi-light.rasi ~/.config/wal/templates/colors-rofi-light.rasi.backup
	ln -s ~/hyprdots/rofi/templates/colors-rofi-light.rasi ~/.config/templates/

	# For screenshotting
	pacman -S --needed hyprpicker hyprshot 

	# For playing media
	pacman -S --needed playerctl
	
	# Wallpaper
	pacman -S --needed swww

	read -p "Do you want widgets installed? yay will be installed if it is not already present[Y/n]" eww
	if [[ $eww =~ [Yy]$ ]]; then
		# Widgets 
		pacman -S --needed yay
		yay -S eww
		mkdir ~/.config/eww
		mv ~/.config/eww/eww.yuck ~/.config/eww/eww.yuck.backup
		mv ~/.config/eww/eww.scss ~/.config/eww/eww.scss.backup
		ln -s ~/hyprdots/eww/eww.yuck ~/.config/eww/
		ln -s ~/hyprdots/eww/eww.scss ~/.config/eww/
		for d in eww/*/; do
			mkdir ~/.config/eww/$d
			ln -s ~/hyprdots/eww/$d.yuck ~/.config/eww/$d/
			ln -s ~/hyprdots/eww/$d.scss ~/.config/eww/$d/
		done
	fi

	ln -s ~/hyprdots/scripts/changeWallpaper /usr/local/bin/
	ln -s ~/hyprdots/scripts/toggleWaybar  /usr/local/bin/
	mkdir ~/.config/hypr/
	mv ~/.config/hypr/hyprland.conf ~/.config/hypr/hyprland.conf.backup
	ln -s ~/hyprdots/hypr/hyprland.conf ~/.config/hypr/
	hyprctl reload
fi

echo

read -p "Do you want the hyprlock/hypridle config installed?[Y/n]" hyprlock
if [[ $hyprlock =~ [Yy]$ ]]; then
	pacman -S --needed hypridle hyprlock
	mkdir ~/.config/hypr/
	mv ~/.config/hypr/hyprlock.conf ~/.config/hypr/hyprlock.conf.backup
	mv ~/.config/hypr/hypridle.conf ~/.config/hypr/hypridle.conf.backup
	ln -s ~/hyprdots/hypr/hyprlock.conf ~/.config/hypr/
	ln -s ~/hyprdots/hypr/hypridle.conf ~/.config/hypr/
	cp "The Wild Breath of Zelda.otf" ~/.local/share/fonts/
	systemctl --user enable --now hypridle
fi

echo

read -p "Do you want the kitty config installed?[Y/n]" kitty
if [[ $kitty =~ [Yy]$ ]]; then
	mkdir ~/.config/kitty/
	mv ~/.config/kitty/kitty.conf ~/.config/kitty/kitty.conf.backup
	ln -s ~/hyprdots/kitty/kitty.conf ~/.config/kitty/
fi

echo

read -p "Do you want the waybar config installed?[Y/n]" waybar
if [[ $waybar =~ [Yy]$ ]]; then
	pacman -S --needed waybar ttf-font-awesome
	mkdir ~/.config/waybar
	mv ~/.config/waybar/config.jsonc ~/.config/waybar/config.jsonc.backup
	mv ~/.config/waybar/style.css ~/.config/waybar/style.css.backup
	ln -s ~/hyprdots/waybar/config.jsonc ~/.config/waybar/
	ln -s ~/hyprdots/waybar/style.css ~/.config/waybar/
fi

read -p "Do you want the bash config installed?[Y/n]" bashconf 
if [[ $bashconf =~ [Yy]$ ]]; then
	mv ~/.bashrc ~/.bashrc.backup
	ln -s ~/hyprdots/.bashrc ~/.bashrc
fi

echo "REMEMBER TO CHANGE YOUR KEYBOARD DISTRO MANUALLY IN HYPRLAND.CONF"
