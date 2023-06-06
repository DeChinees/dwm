#!/bin/sh
sudo xbps-install -Suy
sudo xbps-install -u xbps
sudo xbps-install -Suy void-repo-nonfree tlp powertop mesa-dri socklog-void git seatd wayland wlroots base-devel wlroots-devel 
sudo xbps-install -Suy intel-ucode

sudo dracut --regenerate --force

sudo usermod -aG _seatd ${USER}
sudo usermod -aG socklog ${USER}

sudo ln -s /etc/sv/tlp /var/service
sudo ln -s /etc/sv/socklog-unix /var/service
sudo ln -s /etc/sv/seatd /var/service

mkdir -p /home/${USER}/.dwl
echo "export XDG_RUNTIME_DIR=/home/${USER}/.dwl" >> /home/${USER}/.bashrc

echo "modprobe -r usbmouse" | sudo tee -a /etc/rc.local > /dev/null 
echo "modprobe -r bcm5974" | sudo tee -a /etc/rc.local > /dev/null
echo "modprobe bcm5974" | sudo tee -a /etc/rc.local > /dev/null
echo "modprobe powertop --autotune" | sudo tee -a /etc/rc.local > /dev/null

sudo reboot
