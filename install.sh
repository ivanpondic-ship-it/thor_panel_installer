
#!/bin/bash

echo "==== Xtream Codes v1.0.60 Installer for Ubuntu 22.04 ===="

# -------------------- GÜNCEL PAKETLER --------------------
sudo apt update && sudo apt upgrade -y

# Apache, MySQL, PHP7.2 kurulumu
sudo add-apt-repository ppa:ondrej/php -y
sudo apt update
sudo apt install apache2 mysql-server unzip wget curl -y
sudo apt install php7.2 php7.2-mysql php7.2-curl php7.2-cli php7.2-mbstring php7.2-xml libapache2-mod-php7.2 -y

# Apache PHP modülü etkinleştirme
sudo a2enmod php7.2
sudo systemctl restart apache2

# phpMyAdmin kurulumu (manuel şifre girilecek)
sudo apt install phpmyadmin -y

# -------------------- XTREAM CODES PANEL --------------------
cd /var/www/html
sudo wget https://github.com/amin015/xtream-codes-nulled/archive/refs/heads/master.zip -O xtream.zip
sudo unzip xtream.zip
sudo mv xtream-codes-nulled-master xtreamcodes
sudo chmod -R 755 xtreamcodes

# -------------------- MYSQL AYARLARI --------------------
sudo mysql -u root <<EOF
CREATE DATABASE xtreamcodes;
CREATE USER 'xtream'@'localhost' IDENTIFIED BY 'Xtream@2025!';
GRANT ALL PRIVILEGES ON xtreamcodes.* TO 'xtream'@'localhost';
FLUSH PRIVILEGES;
EOF

echo "==== XTREAM CODES KURULDU ===="
echo "Panel: http://sunucu-ip:8000/admin"
echo "Kullanıcı: admin / admin"

# -------------------- UFW Port Aç --------------------
sudo ufw allow 8000
sudo ufw allow 80

# -------------------- BİTTİ --------------------
