#!/bin/bash

# === Thor Stream PANEL Installer Script ===
INSTALL_DIR="/opt/thor"
PASSWORD_HASH="6a4065b818d6f2e600034f6db79dfb02"

# === Login ===
clear
echo "=========================="
echo " Thor Stream PANEL Login "
echo "=========================="
read -s -p "Password: " input_pwd
echo ""
input_hash=$(echo -n "$input_pwd" | md5sum | awk '{print $1}')

if [ "$input_hash" != "$PASSWORD_HASH" ]; then
  echo "❌ Access denied."
  exit 1
fi

# === Check if server is compatible ===
echo "Checking server requirements..."
if ! command -v unzip &> /dev/null || ! command -v wget &> /dev/null; then
  echo "❌ Required packages (unzip, wget) are missing."
  exit 1
fi

# === Main Menu ===
while true; do
  clear
  echo "=============================="
  echo "   Thor Stream PANEL Menu"
  echo "=============================="
  echo " 1) Install Main Server"
  echo " 2) Install Load Balancer"
  echo " 3) Update Main Server"
  echo " 4) Update GeoLite"
  echo " 5) Exit Installer"
  echo "=============================="
  read -p "Select: " choice

  case $choice in
    1)
      echo "Installing Main Server..."
      mkdir -p $INSTALL_DIR
      wget -q --no-check-certificate "https://drive.google.com/uc?export=download&id=1PMi7EX9JE0JN5Jl7HXMQfzUBT6VvRVHF" -O thor_installer.zip
      unzip -o thor_installer.zip -d $INSTALL_DIR
      echo "✅ Main Server Installation completed."
      read -p "[ENTER] Return to menu..."
      ;;
    2)
      echo "Installing Load Balancer..."
      mkdir -p $INSTALL_DIR
      wget -q --no-check-certificate "https://drive.google.com/uc?export=download&id=13fEhJEJx-E2wCErUEd1WtyjY4Wz2L8nt" -O thor_lb_installer.zip
      unzip -o thor_lb_installer.zip -d $INSTALL_DIR
      echo "✅ Load Balancer Installation completed."
      read -p "[ENTER] Return to menu..."
      ;;
    3)
      echo "Updating Main Server..."
      wget -q --no-check-certificate "https://drive.google.com/uc?export=download&id=1rRJ2Mo_RNLNeAqv6pU1Be1MpUKcVf3N6" -O thor_update.zip
      unzip -o thor_update.zip -d $INSTALL_DIR
      echo "✅ Main Server Update completed."
      read -p "[ENTER] Return to menu..."
      ;;
    4)
      echo "Updating GeoLite2..."
      mkdir -p $INSTALL_DIR/geo
      wget -q https://geolite.maxmind.com/download/geoip/database/GeoLite2-City.tar.gz -O - | tar -xz -C $INSTALL_DIR/geo --strip-components=1
      echo "✅ GeoLite updated."
      read -p "[ENTER] Return to menu..."
      ;;
    5)
      echo "Exiting installer..."
      break
      ;;
    *)
      echo "Invalid selection."
      read -p "[ENTER] Return to menu..."
      ;;
  esac
done
