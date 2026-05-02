#!/bin/bash

#install
rm -rf sparkypanel.sh
apt update && apt upgrade
apt install python3 python3-pip git
git clone https://github.com/xploitoverload/sparkypanel.git
unzip sparkypanel/sparkypanel.zip
pip3 install -r sparkypanel/requirements.txt
pip3 install pillow

#isi data
echo ""
read -e -p "[*] Input your Bot Token : " bottoken
read -e -p "[*] Input Your Id Telegram :" admin
read -e -p "[*] Input Your Subdomain :" domain
echo -e BOT_TOKEN='"'$bottoken'"' >> /root/sparkypanel/var.txt
echo -e ADMIN='"'$admin'"' >> /root/sparkypanel/var.txt
echo -e DOMAIN='"'$domain'"' >> /root/sparkypanel/var.txt
clear
echo "Done Script By xploitoverload"
echo "Your Data Bot"
echo -e "==============================="
echo "Bot Token     : $bottoken"
echo "Id Telegram   : $admin"
echo "Subdomain     : $domain"
echo -e "==============================="
echo "Setting done Please wait 10s"
sleep 10

cat > /etc/systemd/system/sparkypanel.service << END
[Unit]
Description=Simple sparkypanel - @xploitoverload
After=network.target

[Service]
WorkingDirectory=/root
ExecStart=/usr/bin/python3 -m sparkypanel
Restart=always

[Install]
WantedBy=multi-user.target
END

systemctl start sparkypanel 
systemctl enable sparkypanel

clear

echo -e "==============================================="
echo " Installations complete, type /menu on your bot"
echo -e "==============================================="
read -n 1 -s -r -p "Press any key to Reboot"
rm -rf sparkypanel.sh
clear
reboot

