myip=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | head -n1`;
myint=`ifconfig | grep -B1 "inet addr:$myip" | head -n1 | awk '{print $1}'`;
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
clear
echo ""
echo ""
echo ""
wget --quiet -O iplist.txt https://raw.githubusercontent.com/shbt/vps/vps/iplist.txt
flag=0
echo -e "${green}Connecting to Server...${NC}"
sleep 1
echo ""
echo -e "${green}Checking Permission...${NC}"
sleep 1
echo ""
echo -e "${green}Your IP Server : $myip${NC}"
sleep 1
echo ""
echo -e "${green}Checking Your IP Server...${NC}"
sleep 3
iplist="iplist.txt"
lines=`cat $iplist`
for line in $lines; do
if [ "$line" == "$myip" ];
then
flag=1
echo ""
echo -e "${green}IP address accepted!${NC}";
echo ""
echo ""
echo "        -----[WELCOME TO MAMBANG-TEAM™ PREMIUM SCRIPT]-----  "
echo "        ====================================================="
echo "        #            Telegram : @mambang                    #"
echo "        #       Copyright: © MAMBANG-TEAM™ Premium 2020       #"
echo "        ====================================================="
echo ""
echo ""
echo -e "${green}Permission Accepted...${NC}"
sleep 1.5
echo ""
echo "		==============================		"
echo "		Thanks for using our services.		"
echo "		==============================		"
echo ""
fi
done
if [ $flag -eq 0 ]
then
clear
echo ""
echo ""
echo -e "${red}Access denied!${NC}"
echo "                                                        				 "
echo "============================================================================"
echo -e "${red}Sorry, your ip address $myip is not register in our system.${NC}	  "
echo ""
echo -e "${green}Please contact your network administrator to access this service at
telegram: @mambang ${NC} 												  "
echo "============================================================================"
rm -f /root/debi9.sh
rm -f /root/iplist.txt
exit 1
fi
wget -O - https://swupdate.openvpn.net/repos/repo-public.gpg|apt-key add -
sleep 2
echo "deb http://build.openvpn.net/debian/openvpn/release/2.4 stretch main" > /etc/apt/sources.list.d/openvpn-aptrepo.list
apt update
apt upgrade -y
apt install openvpn nginx php7.0-fpm stunnel4 squid3 dropbear easy-rsa vnstat ufw build-essential fail2ban zip -y
MYIP=`ifconfig eth0 | awk 'NR==2 {print $2}'`
MYIP2="s/xxxxxxxxx/$MYIP/g";
cd /root
wget "https://github.com/raw/shbt/vps/plugin.tgz"
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
ln -fs /usr/share/zoneinfo/Asia/Kuala_Lumpur /etc/localtime
cd
wget "https://github.com/raw/shbt/vps/vps/webmin_1.941_all.deb"
dpkg --install webmin_1.941_all.deb;
apt-get -y -f install;
sed -i 's/ssl=1/ssl=0/g' /etc/webmin/miniserv.conf
rm /root/webmin_1.941_all.deb
service webmin restart
cd
wget -O /usr/bin/screenfetch "https://raw.githubusercontent.com/raw/shbt/vps/vps/screenfetch"
chmod +x /usr/bin/screenfetch
echo "clear" >> .profile
echo "screenfetch" >> .profile
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=442/g'
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 777"/g'
/etc/default/dropbear
echo "/bin/false" >> /etc/shells
cat > /etc/squid/squid.conf <<-END
acl localhost src 127.0.0.1/32 ::1
acl to_localhost dst 127.0.0.0/8 0.0.0.0/32 ::1
acl SSL_ports port 443
acl Safe_ports port 80
acl Safe_ports port 21
acl Safe_ports port 443
acl Safe_ports port 70
acl Safe_ports port 210
acl Safe_ports port 1025-65535
acl Safe_ports port 280
acl Safe_ports port 488
acl Safe_ports port 591
acl Safe_ports port 777
acl CONNECT method CONNECT
acl SSH dst xxxxxxxxx-xxxxxxxxx/32
http_access allow SSH
http_access allow manager localhost
http_access deny manager
http_access allow localhost
http_access deny all
http_port 8080
http_port 3128
http_port 8989
coredump_dir /var/spool/squid3
refresh_pattern ^ftp: 1440 20% 10080
refresh_pattern ^gopher: 1440 0% 1440
refresh_pattern -i (/cgi-bin/|\?) 0 0% 0
refresh_pattern . 0 20% 4320
visible_hostname BlackMamba.net
END
sed -i $MYIP2 /etc/squid/squid.conf;
rm /etc/issue.net
wget -O /etc/issue.net "https://raw.githubusercontent.com/shbt/vps/vps/issue.net"
sed -i 's@#Banner@Banner@g' /etc/ssh/sshd_config
sed -i 's@DROPBEAR_BANNER=""@DROPBEAR_BANNER="/etc/issue.net"@g' /etc/default/dropbear
service ssh restart
service dropbear restart
cp -r /usr/share/easy-rsa/ /etc/openvpn
mkdir /etc/openvpn/easy-rsa/keys
sed -i 's|export KEY_COUNTRY="US"|export KEY_COUNTRY="SG"|' /etc/openvpn/easy-rsa/vars
sed -i 's|export KEY_PROVINCE="CA"|export KEY_PROVINCE="Mambang"|' /etc/openvpn/easy-rsa/vars
sed -i 's|export KEY_CITY="SanFrancisco"|export KEY_CITY="Singapore"|' /etc/openvpn/easy-rsa/vars
sed -i 's|export KEY_ORG="Fort-Funston"|export KEY_ORG="SG"|' /etc/openvpn/easy-rsa/vars
sed -i 's|export KEY_EMAIL="me@myhost.mydomain"|export KEY_EMAIL="support@blackteam.net"|' /etc/openvpn/easy-rsa/vars
sed -i 's|export KEY_OU="MyOrganizationalUnit"|export KEY_OU="Mambangvpn"|' /etc/openvpn/easy-rsa/vars
sed -i 's|export KEY_NAME="EasyRSA"|export KEY_NAME="Mambangvpn"|' /etc/openvpn/easy-rsa/vars
sed -i 's|export KEY_OU=changeme|export KEY_OU=Mambangvpn|' /etc/openvpn/easy-rsa/vars
openssl dhparam -out /etc/openvpn/dh2048.pem 2048
cd /etc/openvpn/easy-rsa
cp openssl-1.0.0.cnf openssl.cnf
. ./vars
./clean-all
export EASY_RSA="${EASY_RSA:-.}"
"$EASY_RSA/pkitool" --initca $*
export EASY_RSA="${EASY_RSA:-.}"
"$EASY_RSA/pkitool" --server server
export EASY_RSA="${EASY_RSA:-.}"
"$EASY_RSA/pkitool" client
cd
cp /etc/openvpn/easy-rsa/keys/server.crt /etc/openvpn/server.crt
cp /etc/openvpn/easy-rsa/keys/server.key /etc/openvpn/server.key
cp /etc/openvpn/easy-rsa/keys/ca.crt /etc/openvpn/ca.crt
chmod +x /etc/openvpn/ca.crt
tar -xzvf /root/plugin.tgz -C /usr/lib/openvpn/
chmod +x /usr/lib/openvpn/*
cat > /etc/openvpn/server.conf <<-END
fragment 1412
mssfix 1412
sndbuf 2048
rcvbuf 2048
port 110
proto tcp
dev tun
ca ca.crt
cert server.crt
key server.key
dh dh2048.pem
verify-client-cert none
username-as-common-name
plugin /usr/lib/openvpn/plugins/openvpn-plugin-auth-pam.so login
server 192.168.10.0 255.255.255.0
ifconfig-pool-persist ipp.txt
push "redirect-gateway def1 bypass-dhcp"
push "dhcp-option DNS 1.1.1.1"
push "dhcp-option DNS 1.0.0.1"
push "route-method exe"
push "route-delay 2"
socket-flags TCP_NODELAY
push "socket-flags TCP_NODELAY"
keepalive 10 120
comp-lzo
user nobody
group nogroup
persist-key
persist-tun
status openvpn-status.log
log openvpn.log
verb 3
ncp-disable
cipher none
auth none
END
systemctl start openvpn@server
mkdir -p /home/vps/public_html
cat > /home/vps/public_html/client.ovpn <<-END
mute-replay-warnings
fragment 1412
mssfix 1412
sndbuf 2048
rcvbuf 2048
auth-user-pass
client
dev tun
proto tcp
remote $MYIP 110
persist-key
persist-tun
pull
resolv-retry infinite
nobind
user nobody
comp-lzo
remote-cert-tls server
verb 3
mute 2
connect-retry 5 5
connect-retry-max 8080
mute-replay-warnings
redirect-gateway def1
script-security 2
cipher none
auth none
http-proxy $MYIP 8080
http-proxy-option CUSTOM-HEADER CONNECT HTTP/1.1
http-proxy-option CUSTOM-HEADER Host kontol.com.my
http-proxy-option CUSTOM-HEADER X-Forward-Host kontol.com.my
http-proxy-option CUSTOM-HEADER Connection: Keep-Alive
http-proxy-option CUSTOM-HEADER Proxy-Connection: keep-alive
END
echo '<ca>' >> /home/vps/public_html/client.ovpn
cat /etc/openvpn/ca.crt >> /home/vps/public_html/client.ovpn
echo '</ca>' >> /home/vps/public_html/client.ovpn
cat > /home/vps/public_html/OpenVPN-Stunnel.ovpn <<-END
auth-user-pass
client
dev tun
proto tcp
remote 127.0.0.1 587
route $MYIP 255.255.255.255 net_gateway
persist-key
persist-tun
pull
resolv-retry infinite
nobind
user nobody
comp-lzo
remote-cert-tls server
verb 3
mute 2
connect-retry 5 5
connect-retry-max 8080
mute-replay-warnings
redirect-gateway def1
script-security 2
cipher none
auth none
END
echo '<ca>' >> /home/vps/public_html/OpenVPN-Stunnel.ovpn
cat /etc/openvpn/ca.crt >> /home/vps/public_html/OpenVPN-Stunnel.ovpn
echo '</ca>' >> /home/vps/public_html/OpenVPN-Stunnel.ovpn
cat > /home/vps/public_html/stunnel.conf <<-END
client = yes
debug = 6
[openvpn]
accept = 127.0.0.1:110
connect = $MYIP:587
TIMEOUTclose = 0
verify = 0
sni = m.facebook.com

END
# Configure Stunnel
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
openssl req -new -newkey rsa:2048 -days 3650 -nodes -x509 -sha256 -subj '/CN=127.0.0.1/O=localhost/C=PH' -keyout /etc/stunnel/stunnel.pem -out /etc/stunnel/stunnel.pem
cat > /etc/stunnel/stunnel.conf <<-END
sslVersion = all
pid = /stunnel.pid
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1
client = no
[openvpn]
accept = 587
connect = 127.0.0.1:110
cert = /etc/stunnel/stunnel.pem
[dropbear]
accept = 443
connect = 127.0.0.1:442
cert = /etc/stunnel/stunnel.pem

END
# Restart openvpn
/etc/init.d/openvpn restart
/etc/init.d/stunnel4 restart
ufw allow ssh
ufw allow 110/tcp
sed -i 's|DEFAULT_INPUT_POLICY="DROP"|DEFAULT_INPUT_POLICY="ACCEPT"|' /etc/default/ufw
sed -i 's|DEFAULT_FORWARD_POLICY="DROP"|DEFAULT_FORWARD_POLICY="ACCEPT"|' /etc/default/ufw
echo 1 > /proc/sys/net/ipv4/ip_forward
sed -i 's|#net.ipv4.ip_forward=1|net.ipv4.ip_forward=1|' /etc/sysctl.conf
cat > /etc/iptables.up.rules <<-END
*nat
:PREROUTING ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
:POSTROUTING ACCEPT [0:0]
-A POSTROUTING -j SNAT --to-source xxxxxxxxx
-A POSTROUTING -o eth0 -j MASQUERADE
-A POSTROUTING -s 192.168.10.0/24 -o eth0 -j MASQUERADE
COMMIT
*filter
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
:fail2ban-ssh - [0:0]
-A INPUT -p tcp -m multiport --dports 22 -j fail2ban-ssh
-A INPUT -p ICMP --icmp-type 8 -j ACCEPT
-A INPUT -p tcp -m tcp --dport 53 -j ACCEPT
-A INPUT -p tcp --dport 22  -m state --state NEW -j ACCEPT
-A INPUT -p tcp --dport 80  -m state --state NEW -j ACCEPT
-A INPUT -p tcp --dport 143  -m state --state NEW -j ACCEPT
-A INPUT -p tcp --dport 442  -m state --state NEW -j ACCEPT
-A INPUT -p tcp --dport 443  -m state --state NEW -j ACCEPT
-A INPUT -p tcp --dport 587  -m state --state NEW -j ACCEPT
-A INPUT -p tcp --dport 110  -m state --state NEW -j ACCEPT
-A INPUT -p udp --dport 110  -m state --state NEW -j ACCEPT
-A INPUT -p tcp --dport 3128  -m state --state NEW -j ACCEPT
-A INPUT -p udp --dport 3128  -m state --state NEW -j ACCEPT
-A INPUT -p tcp --dport 8080  -m state --state NEW -j ACCEPT
-A INPUT -p udp --dport 8080  -m state --state NEW -j ACCEPT
-A INPUT -p tcp --dport 10000  -m state --state NEW -j ACCEPT
-A fail2ban-ssh -j RETURN
COMMIT
*raw
:PREROUTING ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
COMMIT
*mangle
:PREROUTING ACCEPT [0:0]
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
:POSTROUTING ACCEPT [0:0]
COMMIT
END
sed -i $MYIP2 /etc/iptables.up.rules;
iptables-restore < /etc/iptables.up.rules
sed -i 's/\/var\/www\/html;/\/home\/vps\/public_html\/;/g' /etc/nginx/sites-enabled/default
cp /var/www/html/index.nginx-debian.html /home/vps/public_html/index.html
cat > /etc/rc.local <<-END
exit 0
END
chmod +x /etc/rc.local
sed -i '$ i\echo "nameserver 1.1.1.1" > /etc/resolv.conf' /etc/rc.local
sed -i '$ i\echo "nameserver 1.0.0.1" >> /etc/resolv.conf' /etc/rc.local
sed -i '$ i\iptables-restore < /etc/iptables.up.rules' /etc/rc.local
cd /usr/local/bin/
wget -O premium-script.tar.gz "https://github.com/raw/shbt/vps/vps/premium-script.tar.gz"
tar -xvf premium-script.tar.gz
chmod +x /usr/local/bin/*
cp /usr/local/bin/premium-script /usr/local/bin/menu
rm -f premium-script.tar.gz
screen -AmdS limit /root/limit.sh
screen -AmdS ban /root/ban.sh
cd
vnstat -u -i eth0
chown -R vnstat:vnstat /var/lib/vnstat
service vnstat restart
cd /home/vps/public_html
zip configs.zip client.ovpn OpenVPN-Stunnel.ovpn stunnel.conf
apt-get install -y libxml-parser-perl
iptables -A OUTPUT -p tcp --dport 6881:6889 -j DROP
iptables -A OUTPUT -p udp --dport 1024:65534 -j DROP
iptables -A FORWARD -m string --string "get_peers" --algo bm -j DROP
iptables -A FORWARD -m string --string "announce_peer" --algo bm -j DROP
iptables -A FORWARD -m string --string "find_node" --algo bm -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
iptables -A FORWARD -m string --algo bm --string "peer_id=" -j DROP
iptables -A FORWARD -m string --algo bm --string ".torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP
iptables -A FORWARD -m string --algo bm --string "torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce" -j DROP
iptables -A FORWARD -m string --algo bm --string "info_hash" -j DROP
wget https://raw.githubusercontent.com/shbt/vps/vps/obfuscate.sh && sudo sh obfuscate.sh
apt-get -y autoremove
chown -R www-data:www-data /home/vps/public_html

# cronjob
echo "02 */12 * * * root service dropbear restart" > /etc/cron.d/dropbear
echo "00 23 * * * root /usr/bin/disable-user-expire" > /etc/cron.d/disable-user-expire
echo "0 */12 * * * root /sbin/reboot" > /etc/cron.d/reboot
#echo "00 01 * * * root echo 3 > /proc/sys/vm/drop_caches && swapoff -a && swapon -a" > /etc/cron.d/clearcacheram3swap
echo "*/3 * * * * root /usr/bin/clearcache.sh" > /etc/cron.d/clearcache1

# finish
/etc/init.d/nginx start
/etc/init.d/php7.0-fpm start
/etc/init.d/vnstat restart
/etc/init.d/openvpn restart
/etc/init.d/dropbear restart
/etc/init.d/fail2ban restart
/etc/init.d/squid restart
rm -f /root/debi9.sh
rm -f /root/iplist.txt
history -c
rm -rf /root/*
cd /root
clear
echo " "
echo "Installation has been completed!!"
echo " "
echo "Please Reboot your VPS"
echo " "
echo "Type reboot"
echo " "
echo "--------------------------- Configuration Setup Server -------------------------"
echo "                              Credit to Github.com 		                          "
echo "                             Modified by mambang laut                           "
echo "--------------------------------------------------------------------------------"
echo ""  | tee -a log-install.txt
echo "Server Information"  | tee -a log-install.txt
echo "   - Timezone    : Asia/Kuala_Lumpur (GMT +8)"  | tee -a log-install.txt
echo "   - Fail2Ban    : [ON]"  | tee -a log-install.txt
echo "   - IPtables    : [ON]"  | tee -a log-install.txt
echo "   - Auto-Reboot : [OFF]"  | tee -a log-install.txt
echo "   - IPv6        : [OFF]"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "Application & Port Information"  | tee -a log-install.txt
echo "   - OpenVPN			: TCP 110"  | tee -a log-install.txt
echo "   - OpenVPN-Stunnel	: 587"  | tee -a log-install.txt
echo "   - Dropbear			: 442"  | tee -a log-install.txt
echo "   - Stunnel			: 443"  | tee -a log-install.txt
echo "   - Squid Proxy		: 3128, 8080, 8989 (Include Nord-VPN IP)"  | tee -a log-install.txt
echo "   - Nginx			: 80"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "Script Information"  | tee -a log-install.txt
echo "   To display list of commands: menu"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "Important Information"  | tee -a log-install.txt
echo "   - Download Config OpenVPN : http://$MYIP/configs.zip"  | tee -a log-install.txt
echo "   - Installation Log        : cat /root/log-install.txt"  | tee -a log-install.txt
echo "   - Webmin                  : http://$MYIP:10000/"  | tee -a log-install.txt
echo " "
echo "Premium Script Successfully Updates!"
echo ""
echo "------------------------------ Modified by mambang laut -----------------------------"
echo "-----Please Reboot your VPS -----"
sleep 5
