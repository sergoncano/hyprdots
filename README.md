<h1>An auto-colored interface for Hyprland</h1>

![wallpaper](screenshots/wallpaperScreenshot.png)
From window borders and notifications to the terminal and the widgets, (mostly) everything is automatically changed to the color palette of your wallpaper, which you can easily change with the built-in wallpaper selector. And that's the tip of it!

![menus](screenshots/menuScreenshot.png)
The hyprland keybinds and layout let you enjoy a beautiful design while still being centered on functionality and productivity.

<h4> Features: <h4>
<pre>
·Toggleable status bar made with waybar
·Hyprland and services auto-start with uwsm
·Pywal for changing the color palettes of:
  -Dunst
  -Rofi
  -The custom powermenu widget
  -Firefox
  -Hyprland window borders
·QOL like keybindings for screenshotting, volume, brightness...
·Minimalistic Zelda lockscreen managed by hyprlock and triggered by hypridle
·And more
</pre>

![lockscreen](screenshots/lockscreenScreenshot.png)
<h4>Automatic installation included!</h4>
The installer lets you choose which features get installed and which don't (made with love for the people who think a powermenu widget is bloat).

To install them open a new terminal and run:
```
$ git clone https://github.com/sergoncano/hyprdots.git
$ cd hyprdots
$ chmod +x installer.sh; ./installer.sh
```
Run with sudo if needed, although I encourage you to read what the installer does before running it.
As of now the installer only works on arch, change the pacman and yay commands if you wish to run it in another distro.

These dotfiles are my first and hence they are not perfect, but I'll be updating them constantly.
I'm open for suggestions and pull requests. 
