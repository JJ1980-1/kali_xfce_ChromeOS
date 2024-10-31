#!/bin/bash
echo "Installing kali linux with xfce Desktop"
echo " "
echo "Installing Text Editor"
sudo apt install nano
clear
echo "Installing xfce4 Desktop."
sudo apt install xfce4 -y
clear
echo "Changing Repository"
echo " "
sed -i 's/^deb https:\/\/deb.debian.org\/debian bookworm main/#deb https:\/\/deb.debian.org\/debian bookworm main/' /etc/apt/sources.list
sed -i 's/^deb https:\/\/deb.debian.org\/debian bookworm-updates main/#deb https:\/\/deb.debian.org\/debian bookworm-updates main/' /etc/apt/sources.list
sed -i 's/^deb https:\/\/deb.debian.org\/debian-security\/ bookworm-security main/#deb https:\/\/deb.debian.org\/debian-security\/ bookworm-security main/' /etc/apt/sources.list
echo 'deb http://http.kali.org/kali kali-rolling main contrib non-free non-free-firmware' >> /etc/apt/sources.list
clear
echo "Installing keyring"
echo " "
sudo wget https://http.kali.org/pool/main/k/kali-archive-keyring/kali-archive-keyring_2024.1_all.deb
sudo dpkg -i kali-archive-keyring_2024.1_all.deb
rm kali-archive-keyring_2024.1_all.deb
clear
echo "Installing dependencies."
echo " "
sudo apt-get install -f
clear
echo "Updating & installing kali"
sudo apt-get update
sudo apt update && sudo apt full-upgrade -y
sudo apt autoremove -y
clear
echo "Installing kali Base Systym"
echo " "
sudo apt install kali-defaults -y
clear
echo "installing desktop server"
echo " "
sudo apt install xserver-xephyr -y
clear
echo "Installing kali-tweaks"
echo " "
sudo apt install kali-tweaks -y
clear
echo "instlling xfce-terminal"
echo " "
sudo apt install xfce4-terminal -y
clear
echo "Disable lightdm logon"
echo " "
sudo systemctl disable lightdm
clear
echo "installing kali-menu"
sudo apt install kali-menu -y
clear
echo "Making Desktop Launcher"
cat << 'EOF' | sudo tee /usr/bin/gxd > /dev/null
Xephyr -br -fullscreen -resizeable :20 &
sleep 5
sudo -u kali DISPLAY=:20 startxfce4 &> /dev/null &

EOF

echo "Make script executeable"
sudo chmod +x /usr/bin/gxd
clear
echo "Installing tldr"
sudo apt install tldr -y
clear
echo "Finishing setup"
tldr -u
clear
echo "Setup complete"
echo " "
echo "Reboot your ChromeBook. Type gxd to start your desktop"
sleep 30