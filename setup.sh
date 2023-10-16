#!/bin/sh

# Update xbps
sudo xbps-install -Suy
sudo xbps-install -u xbps

# Add repositories and drivers/firmware
sudo xbps-install -Suy void-repo-nonfree void-repo-multilib void-repo-multilib-nonfree mesa-dri
sudo xbps-install -Suy intel-ucode

# Add some utils
sudo xbps-install -Suy tlp tlp-rdw powertop socklog-void dbus elogind brightnessctl NetworkManager bluez preload rsync kate git
sudo xbps-install -Suy xorg-minimal xorg-input-drivers xorg-video-drivers xorg-fonts setxkbmap xauth font-misc-misc terminus-font dejavu-fonts-ttf alsa-utils pipewire alsa-pipewire
sudo xbps-install -Suy kde5 kde5-baseapps firefox-esr
sudo xbps-install -Suy xdg-user-dirs xdg-utils xdg-desktop-portal-wlr xtools micro

# Add some fonts
sudo xbps-install -Suy noto-fonts-tff noto-fonts-tff-extra noto-fonts-emoji otf-font-awesome nerd-fonts-otf

# Set priveledges
sudo usermod -aG socklog ${USER}

# Enable services
sudo ln -s /etc/sv/networkmanager /var/service
sudo ln -s /etc/sv/tlp /var/service
sudo ln -s /etc/sv/socklog-unix /var/service
sudo ln -s /etc/sv/dbus /var/service
sudo ln -s /etc/sv/elogind /var/service
sudo ln -s /usr/share/fontconfig/conf.avail/10-hinting-slight.conf /etc/fonts/conf.d/
sudo ln -s /usr/share/fontconfig/conf.avail/50-user.conf /etc/fonts/conf.d/
sudo ln -s /etc/sv/lxdm /var/service

# Misc. settings
echo "export XDG_RUNTIME_DIR=/tmp" >> /home/${USER}/.bashrc

# Install drivers
echo "modprobe -r usbmouse" | sudo tee -a /etc/rc.local > /dev/null 
echo "modprobe -r bcm5974" | sudo tee -a /etc/rc.local > /dev/null
echo "modprobe bcm5974" | sudo tee -a /etc/rc.local > /dev/null
echo "modprobe powertop --autotune" | sudo tee -a /etc/rc.local > /dev/null

sudo xbps-reconfigure -f fontconfig
sudo dracut --regenerate --force
sudo reboot
