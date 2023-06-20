#!/bin/sh

# Update xbps
sudo xbps-install -Suy
sudo xbps-install -u xbps

# Add repositories and drivers/firmware
sudo xbps-install -Suy void-repo-nonfree void-repo-multilib void-repo-multilib-nonfree mesa-dri
sudo xbps-install -Suy intel-ucode

# Add some utils
sudo xbps-install -Suy tlp tlp-rdw powertop socklog-void dbus elogind brightnessctl NetworkManager
sudo xbps-install -Suy xorg xorg-fonts gdm gnome gnome-apps gnome-control-center gnome-shell-extensions
sudo xbps-install -Suy xdg-user-dirs-gtk xdg-utils xdg-desktop-portal-wlr
sudo xbps-install -Suy alsa-utils pipewire alsa-pipewire

# Add some fonts
sudo xbps-install -Suy noto-fonts-tff noto-fonts-tff-extra noto-fonts-emoji otf-font-awesome nerd-fonts-otf

# Set priveledges
sudo usermod -aG socklog ${USER}

# Remove redundant utils
sudo xbps-remove dhcpcd wpa_supplicant

# Enable services
sudo ln -s /usr/sv/NetworkManager /var/service
sudo ln -s /etc/sv/tlp /var/service
sudo ln -s /etc/sv/socklog-unix /var/service
sudo ln -s /etc/sv/dbus /var/service
sudo ln -s /etc/sv/elogind /var/service
sudo ln -s /usr/share/fontconfig/conf.avail/10-hinting-slight.conf /etc/fonts/conf.d/
sudo ln -s /usr/share/fontconfig/conf.avail/50-user.conf /etc/fonts/conf.d/
sudo ln -s /etc/sv/gdm /var/service

# Disable services
sudo rm /var/service/wpa_supplicant
sudo rm /var/service/dhcpcd

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
