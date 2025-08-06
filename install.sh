#!/bin/bash

# === Thor Stream PANEL Installer Script ===
# Çok dilli kurulum arayüzü (Türkçe, English, Deutsch)

# Ana dizin bilgisi
INSTALL_DIR="/opt/thor"

# === Dil Seçimi Fonksiyonu ===
select_language() {
  clear
  echo "====================="
  echo " Thor Stream PANEL "
  echo "====================="
  echo "  1) Türkçe"
  echo "  2) English"
  echo "  3) Deutsch"
  echo "====================="
  read -p "Dil / Language / Sprache: " lang

  case $lang in
    1)
      MSG_INSTALL="Panel kuruluyor..."
      MSG_UPDATE="Panel güncelleniyor..."
      MSG_GEO="GeoLite2 verisi güncelleniyor..."
      MSG_EXIT="SSH bağlantısı kapatılsın mı? (e/h): "
      MSG_BACK="Ana menüye dönülüyor..."
      TITLE="Thor Stream PANEL Ana Menü"
      ;;
    2)
      MSG_INSTALL="Installing panel..."
      MSG_UPDATE="Updating panel..."
      MSG_GEO="Updating GeoLite2 database..."
      MSG_EXIT="Close SSH session after setup? (y/n): "
      MSG_BACK="Returning to main menu..."
      TITLE="Thor Stream PANEL Main Menu"
      ;;
    3)
      MSG_INSTALL="Panel wird installiert..."
      MSG_UPDATE="Panel wird aktualisiert..."
      MSG_GEO="GeoLite2 wird aktualisiert..."
      MSG_EXIT="SSH-Verbindung schließen? (j/n): "
      MSG_BACK="Zurück zum Hauptmenü..."
      TITLE="Thor Stream PANEL Hauptmenü"
      ;;
    *)
      echo "Defaulting to English."
      lang=2
      select_language
      ;;
  esac
}

# Başlangıçta dil seçimini çağır
select_language

# === Ana Menü Döngüsü ===
while true; do
  clear
  echo "=============================="
  echo "   $TITLE"
  echo "=============================="
  echo " 1) Install / Kur / Installieren"
  echo " 2) Update / Güncelle / Aktualisieren"
  echo " 3) Update GeoLite / GeoLite Güncelle / GeoLite aktualisieren"
  echo " 4) Change Language / Dili Değiştir / Sprache ändern"
  echo " 5) Exit / Çıkış / Beenden"
  echo " 6) Close SSH / SSH'yi Kapat / SSH schließen"
  echo "=============================="
  read -p "Selection: " choice

  case $choice in
    1)
      echo "$MSG_INSTALL"
      mkdir -p $INSTALL_DIR
      wget -q --no-check-certificate "https://drive.google.com/uc?export=download&id=1PMi7EX9JE0JN5Jl7HXMQfzUBT6VvRVHF" -O thor_installer.zip
      unzip -o thor_installer.zip -d $INSTALL_DIR
      echo "✅ Kurulum tamamlandı."
      read -p "[ENTER] devam etmek için..."
      ;;
    2)
      echo "$MSG_UPDATE"
      wget -q --no-check-certificate "https://drive.google.com/uc?export=download&id=1rRJ2Mo_RNLNeAqv6pU1Be1MpUKcVf3N6" -O thor_update.zip
      unzip -o thor_update.zip -d $INSTALL_DIR
      echo "✅ Güncelleme tamamlandı."
      read -p "[ENTER] devam etmek için..."
      ;;
    3)
      echo "$MSG_GEO"
      mkdir -p $INSTALL_DIR/geo
      wget -q https://geolite.maxmind.com/download/geoip/database/GeoLite2-City.tar.gz -O - | tar -xz -C $INSTALL_DIR/geo --strip-components=1
      echo "✅ GeoLite güncellendi."
      read -p "[ENTER] devam etmek için..."
      ;;
    4)
      select_language
      ;;
    5)
      echo "Çıkılıyor..."
      break
      ;;
    6)
      read -p "$MSG_EXIT" close_ssh
      if [[ "$close_ssh" =~ ^[EeYyJj]$ ]]; then
        echo "SSH kapatılıyor..."
        sleep 1
        pkill -KILL -u $(whoami)
      fi
      ;;
    *)
      echo "Hatalı seçim."
      read -p "[ENTER] Ana menüye dön..."
      ;;
  esac
done
