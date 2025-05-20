#!/bin/bash
echo "This installer will prompt you to choose which features of the hyprdots you want installed on your system. 
The script requires yay installed on your system. If using another aur sudo pacman wrapper, please edit this file."
echo

	if [ "$EUID" -eq 0 ]; then
		echo "Do not run this script as sudo. Please read what it does"
		exit
	fi

    cd $(dirname "$0")

    HOMEDIR="/home/$(whoami)"

    read -p "Do you want the general hyprland config installed?[Y/n]" hyprland
    if [[ $hyprland =~ [Yy]$ ]]; then
	# For certain menus
        sudo pacman -S --needed rofi-wayland
        mkdir -p $HOMEDIR/.config/rofi
        sudo mv $HOMEDIR/.config/rofi/config.rasi $HOMEDIR/.config/rofi/config.rasi.backup
        ln -s $HOMEDIR/hyprdots/rofi/config.rasi $HOMEDIR/.config/rofi/
        ln -s $HOMEDIR/hyprdots/rofi/launchpad.rasi $HOMEDIR/.config/rofi/
        ln -s $HOMEDIR/hyprdots/rofi/hiddenFiles.rasi $HOMEDIR/.config/rofi/
        ln -s $HOMEDIR/hyprdots/rofi/wallpaperPicker.rasi $HOMEDIR/.config/rofi/
        mkdir -p $HOMEDIR/.config/wal/templates/
        sudo mv $HOMEDIR/.config/wal/templates/colors-rofi-light.rasi $HOMEDIR/.config/wal/templates/colors-rofi-light.rasi.backup
        ln -s $HOMEDIR/hyprdots/rofi/templates/colors-rofi-light.rasi $HOMEDIR/.config/wal/templates/
        sed -i --follow-symlinks "s|/home/sergio/Pictures/wallpapers|$HOMEDIR/Pictures/wallpapers|" $HOMEDIR/hyprdots/rofi/wallpaperPicker.rasi
        # For playing media
        sudo pacman -S --needed playerctl

        sudo pacman -S --needed python-pywal

        # Wallpaper
        sudo pacman -S --needed swww
	
	# For unit file management
        sudo pacman -S --needed uwsm

        ln -s $HOMEDIR/hyprdots/scripts/changeWallpaper /usr/local/bin/
        ln -s $HOMEDIR/hyprdots/scripts/toggleWaybar /usr/local/bin/
        mkdir -p $HOMEDIR/.config/hypr/
        mv $HOMEDIR/.config/hypr/hyprland.conf $HOMEDIR/.config/hypr/hyprland.conf.backup
        ln -s $HOMEDIR/hyprdots/hypr/hyprland.conf $HOMEDIR/.config/hypr/

        read -p "What keyboard layout do you wish to use? " layout
        sed -i --follow-symlinks "s|kb_layout = es|kb_layout = $layout|" $HOMEDIR/hyprdots/hypr/hyprland.conf

        # For brightness
        read -p "Do you want software for brightness control?[Y/n]" light
        if [[ $light =~ [Yy]$ ]]; then
           yay -S light
        fi

        # For audio control
        read -p "Do you want software for audio control?[Y/n]" audio
        if [[ $audio =~ [Yy]$ ]]; then
            sudo pacman -S --needed pamixer pipewire-alsa wireplumber pipewire-pulse
            systemctl --user --now enable pipewire pipewire-pulse wireplumber
        fi

        # For screenshotting
        read -p "Do you want software for screenshotting?[Y/n]" screenshots
        if [[ $screenshots =~ [Yy]$ ]]; then
            sudo pacman -S --needed hyprpicker
            yay -S hyprshot
        fi

	# For notification colors
        read -p "Do you want the dunst color scheme to change?[Y/n]" dunst
        if [[ $dunst =~ [Yy]$ ]]; then
	    mkdir -p $HOMEDIR/.config/dunst/
            mv $HOMEDIR/.config/dunst/dunstrc $HOMEDIR/.config/dunst/dunstrc.backup
            ln -s $HOMEDIR/hyprdots/dunstrc $HOMEDIR/.config/dunst/
	    echo "Dunst has NOT been installed, do it manually if you don't have it yet."
        fi

	#For the powermenu and certain other widgets
	read -p "Do you want widgets installed?[Y/n]" eww
        if [[ $eww =~ [Yy]$ ]]; then
            # Widgets
	    read -p "Eww will take a longer time to get installed since it is a rust project. Press any key to proceed." dummie
            yay -S eww
            mkdir -p $HOMEDIR/.config/eww
            mv $HOMEDIR/.config/eww/eww.yuck $HOMEDIR/.config/eww/eww.yuck.backup
            mv $HOMEDIR/.config/eww/eww.scss $HOMEDIR/.config/eww/eww.scss.backup
            ln -s $HOMEDIR/hyprdots/eww/eww.yuck $HOMEDIR/.config/eww/
            ln -s $HOMEDIR/hyprdots/eww/eww.scss $HOMEDIR/.config/eww/
            for d in eww/*/; do
                mkdir -p $HOMEDIR/.config/eww/$d
                ln -s $HOMEDIR/hyprdots/eww/$d.yuck $HOMEDIR/.config/eww/$d/
                ln -s $HOMEDIR/hyprdots/eww/$d.scss $HOMEDIR/.config/eww/$d/
            done
        fi
	changeWallpaper $HOMEDIR/hyprdots/assets/lockscreen.jpg

        hyprctl reload
    fi

    echo
    
    # For the lockscreen/screensaver
    read -p "Do you want the hyprlock/hypridle config installed?[Y/n]" hyprlock
    if [[ $hyprlock =~ [Yy]$ ]]; then
        sudo pacman -S --needed hypridle hyprlock
        mkdir -p $HOMEDIR/.config/hypr/
        mv $HOMEDIR/.config/hypr/hyprlock.conf $HOMEDIR/.config/hypr/hyprlock.conf.backup
        mv $HOMEDIR/.config/hypr/hypridle.conf $HOMEDIR/.config/hypr/hypridle.conf.backup
        ln -s $HOMEDIR/hyprdots/hypr/hyprlock.conf $HOMEDIR/.config/hypr/
        ln -s $HOMEDIR/hyprdots/hypr/hypridle.conf $HOMEDIR/.config/hypr/
        mkdir -p $HOMEDIR/.local/share/fonts/
        cp $HOMEDIR/hyprdots/assets/"The Wild Breath of Zelda.otf" $HOMEDIR/.local/share/fonts/
	mkdir -p $HOMEDIR/Pictures/wallpapers/
        ln -s $HOMEDIR/hyprdots/assets/lockscreen.jpg $HOMEDIR/Pictures/wallpapers/
        systemctl --user enable --now hypridle
    fi

    echo

    # For terminal transparency
    read -p "Do you want kitty to be transparent?[Y/n]" kitty
    if [[ $kitty =~ [Yy]$ ]]; then
        mkdir -p $HOMEDIR/.config/kitty/
        mv $HOMEDIR/.config/kitty/kitty.conf $HOMEDIR/.config/kitty/kitty.conf.backup
        ln -s $HOMEDIR/hyprdots/kitty/kitty.conf $HOMEDIR/.config/kitty/
    fi

    echo

    read -p "Do you want the waybar config installed?[Y/n]" waybar
    if [[ $waybar =~ [Yy]$ ]]; then
        sudo pacman -S --needed waybar ttf-font-awesome
        mkdir -p $HOMEDIR/.config/waybar
        sudo mv $HOMEDIR/.config/waybar/config.jsonc $HOMEDIR/.config/waybar/config.jsonc.backup
        sudo mv $HOMEDIR/.config/waybar/style.css $HOMEDIR/.config/waybar/style.css.backup
        ln -s $HOMEDIR/hyprdots/waybar/config.jsonc $HOMEDIR/.config/waybar/
        ln -s $HOMEDIR/hyprdots/waybar/style.css $HOMEDIR/.config/waybar/
        sed -i --follow-symlinks "s|/home/sergio/hyprdots/waybar/republicLogo.png|$HOMEDIR/hyprdots/waybar/republicLogo.png|" $HOMEDIR/hyprdots/waybar/config.jsonc
    fi

    echo

    read -p "Do you want the source code pro font installed?[Y/n]" scp
    if [[ $scp =~ [Yy]$ ]]; then
	    sudo pacman -S adobe-source-code-pro-fonts
    fi

    echo

    read -p "Do you want the nvim config installed?[Y/n]" nvim
    if [[ $nvim =~ [Yy]$ ]]; then
		# npm and unzip must be installed in order for LSPs to work
		sudo pacman -S npm unzip
        mv $HOMEDIR/.config/nvim $HOMEDIR/.config/nvim.old
        ln -s $HOMEDIR/hyprdots/nvim/ $HOMEDIR/.config/
    fi

    echo

    read -p "Do you want hyprland to be launched on login?[Y/n]" bashconf
    if [[ $bashconf =~ [Yy]$ ]]; then
        mv $HOMEDIR/.bashrc $HOMEDIR/.bashrc.backup
        ln -s $HOMEDIR/hyprdots/.bashrc $HOMEDIR/.bashrc
    fi
 
    echo

    read -p "Do you want to get an hourly reminder to take a break from screens?[Y/n]" sight
    if [[ $sight =~ [Yy]$ ]]; then
        ln -s $HOMEDIR/hyprdots/systemd/sight-maintainance.timer $HOMEDIR/.config/systemd/user/
        ln -s $HOMEDIR/hyprdots/systemd/sight-maintainance.service $HOMEDIR/.config/systemd/user/
        systemctl --user enable sight-maintainance.timer
    fi
    hyprctl reload
    echo "!!! THE PYWAL BROWSER EXTENSION MUST BE INSTALLED MANUALLY !!!"
    echo "I recommand setting 'Background extra' to the first color of the second row in the pywal browser config aswell"
