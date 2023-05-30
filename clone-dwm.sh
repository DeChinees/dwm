sudo xbps-install base-devel libX11-devel libXft-devel libXinerama-devel freetype-devel fontconfig-devel

git clone https://git.suckless.org/dwm
git clone https://git.suckless.org/st
git clone https://git.suckless.org/dmenu
git clone https://git.suckless.org/slock


Source: https://lecorbeausvault.wordpress.com/2020/04/08/install-guide-suckless-dwm-with-st-and-dmenu/
        https://faun.pub/the-easiest-way-to-install-dwm-43bbf668ea83
        
cd dwm-*.*
make
sudo make clean install
cd ..
cd st-*.*
make
sudo make clean install
cd ..
cd dmenu-*.*
make
sudo make clean install
cd