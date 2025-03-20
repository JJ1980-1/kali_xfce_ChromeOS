#!/bin/bash
echo "Installing kali linux with xfce Desktop"
echo " "
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
echo "Installing xfce4 Desktop."
sudo apt install xfce4 -y
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

echo "Witch kali installation, do you wan't to install?"
echo ""
echo "1. kali linux Default installation - Disk ussage 9,353 MB"
echo "2. kali linux Large installation - Disk ussage 15.4 GB"
echo "3. Install everything - Disk ussage 31.5 GB"
echo "4. Proceed with minimal installation"

read -p "Choose Installation 1-4" choice
choice=$(echo "$choice" | tr '[:upper:]' '[:lower:]')

case "$choice" in
  1 ) sudo apt install kali-linux-default -y;;
  2 ) sudo apt install kali-linux-large -y;;
  3 ) sudo apt install kali-linux-everything -y;;
  4 ) ;;
esac
clear

echo "Do you wish to install xfce plugins for your Desktop?"

read -p "Install plugins. Yes or No? (y/n)" choice
choice=$(echo "$choice" | tr '[:upper:]' '[:lower:]')

case "$choice" in
 y ) echo "xfce pluins"
     sudo apt install xfce4-goodies -y
     sudo apt install xfce4-datetime-plugin -y
     sudo apt install xfce4-dev-tools -y
     sudo apt install xfce4-docklike-plugin -y
     sudo apt install xfce4-eyes-plugin -y
     sudo apt install xfce4-indicator-plugin -y
     sudo apt install xfce4-mount-plugin -y
     sudo apt install xfce4-mpc-plugin -y
     sudo apt install xfce4-panel-profiles -y
     sudo apt install xfce4-windowck-plugin -y
     sudo apt install xfconf-gsettings-backend -y
     echo "Plugins installed"
     sleep 1;;
 n ) ;;
esac
clear

echo "Do you wish to install flatpak (Gnome App Store)?"

read -p "Install Flatpak Yes or No (y/n)" choice
choice=$(echo "$choice" | tr '[:upper:]' '[:lower:]')

case "$choice" in
  y ) echo "Installing Flatpak"
      sudo apt update
      sudo apt install -y flatpak
      sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      sudo apt install gnome-software-plugin-flatpak -y
      mkdir -p ~/.themes
      cp -a /usr/share/themes/* ~/.themes/
      sudo flatpak override --filesystem=~/.themes/
      echo "Flatpak installed"
      echo ""
      echo "Go to flathub.org for applikations & commands"
      sleep 3;;
  n ) ;;
esac
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