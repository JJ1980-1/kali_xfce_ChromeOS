#!/bin/bash

echo "Installing kali linux with xfce Desktop"
echo -e /n "Installing Text Editor"
sudo apt install nano
clear

exho -e /n "Installing xfce4 Desktop."
sudo apt install xfce4 -y

echo "Changing Repository"

sed -i 's/^deb https:\/\/deb.debian.org\/debian bookworm main/#deb https:\/\/deb.debian.org\/debian bookworm main/' /etc/apt/sources.list
sed -i 's/^deb https:\/\/deb.debian.org\/debian bookworm-updates main/#deb https:\/\/deb.debian.org\/debian bookworm-updates main/' /etc/apt/sources.list
sed -i 's/^deb https:\/\/deb.debian.org\/debian-security\/ bookworm-security main/#deb https:\/\/deb.debian.org\/debian-security\/ bookworm-security main/' /etc/apt/sources.list
echo 'deb http://http.kali.org/kali kali-rolling main contrib non-free non-free-firmware' >> /etc/apt/sources.list


echo -e /n "Installing keyring"

sudo wget https://archive.kali.org/archive-key.asc -O /etc/apt/trusted.gpg.d/kali-archive-keyring.asc
clear

echo "Updating & installing kali"
sudo apt-get update
sudo apt update && sudo apt full-upgrade -y
sudo apt autoremove -y
clear

echo "Installing kali Base Systym"
sudo apt install kali-defaults -y
clear

echo "installing desktop server"
sudo apt install xserver-xephyr -y
clear

echo "Installing kali-tweaks"
sudo apt install kali-tweaks -y
clear

echo "instlling xfce-terminal"
sudo apt install xfce4-terminal -y
clear

echo "Disable lightdm logon"
sudo systemctl disable lightdm
clear

echo "installing kali-menu"
sudo apt install kali-menu -y

echo "Making Desktop Launcher"
cat << 'EOF' | sudo tee /usr/bin/gxd > /dev/null
Xephyr -br -fullscreen -resizeable :20 &
sleep 5
sudo -u kali DISPLAY=:20 startxfce4 &> /dev/null &

EOF

echo "Make script executeable"
sudo chmod +x /usr/bin/gxd

echo "Installing tldr"
sudo apt install tldr -y
clear

echo "Finishing setup"
tldr -u
clear

echo "Setup complete"

echo -e /n "Reboot your ChromeBook. Type gxd to start your desktop"
