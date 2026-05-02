#!/bin/bash
MYIP=$(wget -qO- ipv4.icanhazip.com);
echo "Checking VPS"
clear

banner() {
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\E[0;100;33m      • xploitoverload RESTART MENU •       \E[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
}

pause_menu() {
    read -n 1 -s -r -p "Press any key to back on xploitoverload system menu"
}

restart_all_services() {
    echo -e "[ \033[32mInfo\033[0m ] Restart Begin"
    sleep 1
    /etc/init.d/ssh restart
    /etc/init.d/dropbear restart
    /etc/init.d/stunnel4 restart
    /etc/init.d/openvpn restart
    /etc/init.d/fail2ban restart
    /etc/init.d/cron restart
    /etc/init.d/nginx restart
    /etc/init.d/squid restart
    echo -e "[ \033[32mok\033[0m ] Restarting xray Service (via systemctl) "
    sleep 0.5
    systemctl restart xray
    systemctl restart xray.service
    echo -e "[ \033[32mok\033[0m ] Restarting badvpn Service (via systemctl) "
    sleep 0.5
    screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500
    screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500
    screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500
    echo -e "[ \033[32mok\033[0m ] Restarting websocket Service (via systemctl) "
    sleep 0.5
    systemctl restart sshws.service
    systemctl restart ws-dropbear.service
    systemctl restart ws-stunnel.service
    echo -e "[ \033[32mok\033[0m ] Restarting Trojan Go Service (via systemctl) "
    sleep 0.5
    systemctl restart trojan-go.service
    echo -e "[ \033[32mInfo\033[0m ] ALL Service Restarted"
}

restart_service() {
    service_command="$1"
    success_message="$2"
    echo -e "[ \033[32mInfo\033[0m ] Restart Begin"
    sleep 1
    eval "$service_command"
    sleep 0.5
    echo -e "[ \033[32mInfo\033[0m ] ${success_message}"
}

banner
echo -e ""
echo -e " [\e[36m•1\e[0m] Restart All Services"
echo -e " [\e[36m•2\e[0m] Restart OpenSSH"
echo -e " [\e[36m•3\e[0m] Restart Dropbear"
echo -e " [\e[36m•4\e[0m] Restart Stunnel4"
echo -e " [\e[36m•5\e[0m] Restart OpenVPN"
echo -e " [\e[36m•6\e[0m] Restart Squid"
echo -e " [\e[36m•7\e[0m] Restart Nginx"
echo -e " [\e[36m•8\e[0m] Restart Badvpn"
echo -e " [\e[36m•9\e[0m] Restart XRAY"
echo -e " [\e[36m10\e[0m] Restart WEBSOCKET"
echo -e " [\e[36m11\e[0m] Restart Trojan Go"
echo -e ""
echo -e " [\e[31m•0\e[0m] \e[31mBACK TO xploitoverload MENU\033[0m"
echo -e ""
echo -e "Press x or [ Ctrl+C ] • To-Exit"
echo -e ""
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
read -p " Select menu : " Restart
echo -e ""

case $Restart in
    1)
        banner
        echo -e ""
        restart_all_services
        echo -e ""
        echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo -e ""
        pause_menu
        restart
        ;;
    2)
        banner
        echo -e ""
        restart_service "/etc/init.d/ssh restart" "SSH Service Restarted"
        echo -e ""
        echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo -e ""
        pause_menu
        restart
        ;;
    3)
        banner
        echo -e ""
        restart_service "/etc/init.d/dropbear restart" "Dropbear Service Restarted"
        echo -e ""
        echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo -e ""
        pause_menu
        restart
        ;;
    4)
        banner
        echo -e ""
        restart_service "/etc/init.d/stunnel4 restart" "Stunnel4 Service Restarted"
        echo -e ""
        echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo -e ""
        pause_menu
        restart
        ;;
    5)
        banner
        echo -e ""
        restart_service "/etc/init.d/openvpn restart" "Openvpn Service Restarted"
        echo -e ""
        echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo -e ""
        pause_menu
        restart
        ;;
    6)
        banner
        echo -e ""
        restart_service "/etc/init.d/squid restart" "Squid Service Restarted"
        echo -e ""
        echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo -e ""
        pause_menu
        restart
        ;;
    7)
        banner
        echo -e ""
        restart_service "/etc/init.d/nginx restart" "Nginx Service Restarted"
        echo -e ""
        echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo -e ""
        pause_menu
        restart
        ;;
    8)
        banner
        echo -e ""
        echo -e "[ \033[32mInfo\033[0m ] Restart Begin"
        sleep 1
        echo -e "[ \033[32mok\033[0m ] Restarting badvpn Service (via systemctl) "
        screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500
        echo -e "[ \033[32mInfo\033[0m ] Badvpn Service Restarted"
        echo -e ""
        echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo -e ""
        pause_menu
        restart
        ;;
    9)
        banner
        echo -e ""
        echo -e "[ \033[32mInfo\033[0m ] Restart Begin"
        sleep 1
        echo -e "[ \033[32mok\033[0m ] Restarting xray Service (via systemctl) "
        systemctl restart xray
        systemctl restart xray.service
        echo -e "[ \033[32mInfo\033[0m ] XRAY Service Restarted"
        echo -e ""
        echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo -e ""
        pause_menu
        restart
        ;;
    10)
        banner
        echo -e ""
        echo -e "[ \033[32mInfo\033[0m ] Restart Begin"
        sleep 1
        echo -e "[ \033[32mok\033[0m ] Restarting websocket Service (via systemctl) "
        systemctl restart sshws.service
        systemctl restart ws-dropbear.service
        systemctl restart ws-stunnel.service
        echo -e "[ \033[32mInfo\033[0m ] WEBSOCKET Service Restarted"
        echo -e ""
        echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo -e ""
        pause_menu
        restart
        ;;
    11)
        banner
        echo -e ""
        echo -e "[ \033[32mInfo\033[0m ] Restart Begin"
        sleep 1
        echo -e "[ \033[32mok\033[0m ] Restarting Trojan Go Service (via systemctl) "
        systemctl restart trojan-go.service
        echo -e "[ \033[32mInfo\033[0m ] Trojan Go Service Restarted"
        echo -e ""
        echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo -e ""
        pause_menu
        restart
        ;;
    0)
        m-system
        exit
        ;;
    x)
        exit
        ;;
    *)
        echo -e ""
        echo "xploitoverload"
        echo -e ""
        pause_menu
        restart
        ;;
esac
