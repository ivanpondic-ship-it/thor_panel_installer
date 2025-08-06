#!/bin/bash

# === Thor Stream PANEL Installer Script ===
# Çok dilli kurulum arayüzü (Türkçe, English, Deutsch)

# Ana dizin bilgisi
INSTALL_DIR="/opt/thor"

clear

# === Dil Seçimi ===
echo "====================================="
echo "      Thor Stream PANEL Kurulum"
echo "====================================="
echo "  1) Türkçe"
echo "  2) English"
echo "  3) Deutsch"
echo "====================================="
read -p "Dil / Language / Sprache: " lang

select_language() {
  case $lang in
    1)
      MSG_INSTALL="Panel kuruluyor..."
      MSG_UPDATE="Panel güncelleniyor..."
      MSG_GEO="GeoLite2 verisi güncelleniyor..."
      MSG_EXIT="SSH bağlantısı kapatılsın mı? (e/h): "
      MSG_BACK="Ana menüye dönülüyor..."
      MENU="\n1) Paneli Kur\n2) Paneli Güncelle\n3) GeoLite Güncelle\n4) SSH'yi Kapat\n5) Dil Seçimini Değiştir\n6) Çıkış\nSeçiminiz: "
      ;;
    2)
      MSG_INSTALL="Installing panel..."
      MSG_UPDATE="Updating panel..."
      MSG_GEO="Updating GeoLite2 database..."
      MSG_EXIT="Close SSH session after setup? (y/n): "
      MSG_BACK="Returning to main menu..."
      MENU="\n1) Install Panel\n2) Update Panel\n3) Update GeoLite\n4) Close SSH\n5) Change Language\n6) Exit\nYour choice: "
      ;;
    3)
      MSG_INSTALL="Panel wird installiert..."
      MSG_UPDATE="Panel wird aktualisiert..."
      MSG_GEO="GeoLite2 wird aktualisiert..."
      MSG_EXIT="SSH-Verbindung schließen? (j/n): "
      MSG_BACK="Zurück zum Hauptmenü..."
      MENU="\n1) Panel installieren\n2) Panel aktualisieren\n3) GeoLite aktualisieren\n4) SSH schließen\n5) Sprache ändern\n6) Beenden\nAuswahl: "
      ;;
    *)
      echo "Defaulting to English."
      lang=2
      select_language
      ;;
  esac
}

select_language

while true; do
  echo -e "$MENU"
  read choice
  case $choice in
    1)
      echo "$MSG_INSTALL"
      mkdir -p $INSTALL_DIR
      wget -q --no-check-certificate "https://drive.google.com/uc?export=download&id=1PMi7EX9JE0JN5Jl7HXMQfzUBT6VvRVHF" -O thor_installer.zip
      unzip -o thor_installer.zip -d $INSTALL_DIR
      echo "✅ Kurulum tamamlandı."
      read -p "[ENTER] Ana menüye dön..."
      ;;
    2)
      echo "$MSG_UPDATE"
      wget -q --no-check-certificate "https://drive.google.com/uc?export=download&id=1rRJ2Mo_RNLNeAqv6pU1Be1MpUKcVf3N6" -O thor_update.zip
      unzip -o thor_update.zip -d $INSTALL_DIR
      echo "✅ Güncelleme tamamlandı."
      read -p "[ENTER] Ana menüye dön..."
      ;;
    3)
      echo "$MSG_GEO"
      mkdir -p $INSTALL_DIR/geo
      wget -q https://geolite.maxmind.com/download/geoip/database/GeoLite2-City.tar.gz -O - | tar -xz -C $INSTALL_DIR/geo --strip-components=1
      echo "✅ GeoLite güncellendi."
      read -p "[ENTER] Ana menüye dön..."
      ;;
    4)
      read -p "$MSG_EXIT" close_ssh
      if [[ "$close_ssh" =~ ^[EeYyJj]$ ]]; then
        echo "SSH kapatılıyor..."
        sleep 1
        pkill -KILL -u $(whoami)
      fi
      ;;
    5)
      clear
      echo "Dil seçimi ekranına dönülüyor..."
      echo "====================="
      echo " Thor Stream PANEL "
      echo "====================="
      read -p "[ENTER] devam etmek için..."
      clear
      echo ""
      echo "====================================="
      echo "      Thor Stream PANEL Kurulum"
      echo "====================================="
      echo "  1) Türkçe"
      echo "  2) English"
      echo "  3) Deutsch"
      echo "====================================="
      read -p "Dil / Language / Sprache: " lang
      select_language
      ;;
    6)
      echo "Çıkılıyor..."
      break
      ;;
    *)
      echo "Hatalı seçim."
      ;;
  esac
done
