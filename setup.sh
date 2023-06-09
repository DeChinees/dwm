#!/bin/sh
# Update xbps
sudo xbps-install -Suy
sudo xbps-install -u xbps

# Add repositories and drivers/firmware
sudo xbps-install -Suy void-repo-nonfree void-repo-multilib void-repo-multilib-nonfree mesa-dri
sudo xbps-install -Suy intel-ucode

# Add some utils
sudo xbps-install -Suy tlp powertop socklog-void git seatd xorg-fonts
sudo xbps-install -Suy wayland wlroots sway swayidle swayimg swaylock bemenu foot qutebrowser
sudo xbps-install -Suy xdg-user-dirs xdg-utils xdg-desktop-portal-wlr
sudo xbps-install -Suy alsa-utils pipewire alsa-pipewire

# Add some fonts
sudo xbps-install -Suy noto-fonts-emoji noto-fonts-emoji otf-font-awesome nerd-fonts-otf

sudo usermod -aG _seatd ${USER}
sudo usermod -aG socklog ${USER}

sudo ln -s /etc/sv/tlp /var/service
sudo ln -s /etc/sv/socklog-unix /var/service
sudo ln -s /etc/sv/seatd /var/service
sudo ln -s /usr/share/fontconfig/conf.avail/10-hinting-slight.conf /etc/fonts/conf.d/
sduo ln -s /usr/share/fontconfig/conf.avail/50-user.conf /etc/fonts/conf.d/

echo "export XDG_RUNTIME_DIR=/tmp" >> /home/${USER}/.bashrc

echo "modprobe -r usbmouse" | sudo tee -a /etc/rc.local > /dev/null 
echo "modprobe -r bcm5974" | sudo tee -a /etc/rc.local > /dev/null
echo "modprobe bcm5974" | sudo tee -a /etc/rc.local > /dev/null
echo "modprobe powertop --autotune" | sudo tee -a /etc/rc.local > /dev/null

sudo xbps-reconfigure -f fontconfig
sudo dracut --regenerate --force
sudo reboot
