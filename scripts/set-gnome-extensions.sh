# Disable default GNOME extensions
gnome-extensions disable tiling-assistant@ubuntu.com
gnome-extensions disable ubuntu-appindicators@ubuntu.com
gnome-extensions disable ubuntu-dock@ubuntu.com
gnome-extensions disable ding@rastersoft.com

# Install gnome-shell-extension-manager and pipx
sudo apt install -y gnome-shell-extension-manager pipx
pipx install gnome-extensions-cli --system-site-packages

# Install extensions
gext install appindicatorsupport@rgcjonas.gmail.com               # AppIndicator and KStatusNotifierItem Support
gext install apps-menu@gnome-shell-extensions.gcampax.github.com  # Apps Menu
gext install blur-my-shell@aunetx                                 # Blur my Shell
gext install caffeine@patapon.info                                # Caffeine
gext install dash-to-dock@micxgx.gmail.com                        # Dash to Dock
gext install drive-menu@gnome-shell-extensions.gcampax.github.com # Removable Drive Menu
gext install osd-volume-number@deminder                           # OSD Volume Number
gext install quick-settings-tweaks@qwreey                         # Quick Settings Tweaks
gext install user-theme@gnome-shell-extensions.gcampax.github.com # User Themes

# gsettings list-recursively | grep -i org.gnome.shell.extensions
