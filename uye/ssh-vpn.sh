#!/bin/bash
# Edition : Stable Edition V3.0
# =========================================

# // Exporting Language to UTF-8
export LC_ALL='en_US.UTF-8' >/dev/null 2>&1
export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'
export LC_CTYPE='en_US.utf8'

# // Export Color & Information
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CYAN='\033[0;36m'
export LIGHT='\033[0;37m'
export NC='\033[0m'
grenbo="\e[92;1m"
NC='\033[0m'

# // Export Banner Status Information
export EROR="[${RED} EROR ${NC}]"
export INFO="[${YELLOW} INFO ${NC}]"
export OKEY="[${GREEN} OKEY ${NC}]"
export PENDING="[${YELLOW} PENDING ${NC}]"
export SEND="[${YELLOW} SEND ${NC}]"
export RECEIVE="[${YELLOW} RECEIVE ${NC}]"
clear
date
echo ""

# initializing var
export DEBIAN_FRONTEND=noninteractive
MYIP=$(wget -qO- ipinfo.io/ip);
MYIP2="s/xxxxxxxxx/$MYIP/g";
NET=$(ip -o $ANU -4 route show to default | awk '{print $5}');
source /etc/os-release
ver=$VERSION_ID

#detail nama perusahaan
country=ID
state=Indonesia
locality=Indonesia
organization=geovpn
organizationalunit=geovpn
commonname=geovpn
email=admin@geolstore.net

# simple password minimal
wget -O /etc/pam.d/common-password "https://raw.githubusercontent.com/Jatimpark/multi/main/uye/password" >/dev/null 2>&1
chmod +x /etc/pam.d/common-password >/dev/null 2>&1

# go to root
cd

# Edit file /etc/systemd/system/rc-local.service
cat > /etc/systemd/system/rc-local.service <<-END
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local
[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99
[Install]
WantedBy=multi-user.target
END

# nano /etc/rc.local
cat > /etc/rc.local <<-END
#!/bin/sh -e
# rc.local
# By default this script does nothing.
exit 0
END

sleep 1
# Ubah izin akses
echo -e "[ ${BLUE}NOTES${NC} ] Ubah izin akses"
chmod +x /etc/rc.local
sleep 1
# enable rc local
echo -e "[ ${BLUE}NOTES${NC} ] enable rc local"
systemctl enable rc-local
systemctl start rc-local.service

# disable ipv6
echo -e "[ ${BLUE}NOTES${NC} ] disable ipv6 "
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local

sleep 1
#update
clear
# set time GMT +7
echo -e "[ ${BLUE}NOTES${NC} ] set time GMT +7"
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
echo ""
# set locale
echo -e "[ ${BLUE}NOTES${NC} ] set locale"
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config

cd

# install badvpn
echo -e "[ ${GREEN}INFO${NC} ] install badvpn-udpgw64"
cd
wget -O /usr/bin/badvpn-udpgw "https://raw.githubusercontent.com/Jatimpark/multi/main/uye/badvpn-udpgw64"
chmod +x /usr/bin/badvpn-udpgw
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500' /etc/rc.local
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7400 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7500 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7600 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7700 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7800 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7900 --max-clients 500

sleep 1
clear
# setting port ssh
echo -e "[ ${GREEN}INFO${NC} ] install sshd"
cd
sed -i 's/Port 22/Port 22/g' /etc/ssh/sshd_config
/etc/init.d/ssh restart
/etc/init.d/ssh status
# install squid
echo -e "[ ${GREEN}INFO${NC} ] install squid"
cd
apt -y install squid3 >/dev/null 2>&1
wget -O /etc/squid/squid.conf "https://raw.githubusercontent.com/Jatimpark/multi/main/uye/squid3.conf"
sed -i $MYIP2 /etc/squid/squid.conf

# Install SSLH
echo -e "[ ${GREEN}INFO${NC} ] install sslh"
apt -y install sslh
rm -f /etc/default/sslh

# Settings SSLH
echo -e "[ ${BLUE}NOTES${NC} ] Settings SSLH"
cat > /etc/default/sslh <<-END
# Default options for sslh initscript
# sourced by /etc/init.d/sslh

# Disabled by default, to force yourself
# to read the configuration:
# - /usr/share/doc/sslh/README.Debian (quick start)
# - /usr/share/doc/sslh/README, at "Configuration" section
# - sslh(8) via "man sslh" for more configuration details.
# Once configuration ready, you *must* set RUN to yes here
# and try to start sslh (standalone mode only)

RUN=yes

# binary to use: forked (sslh) or single-thread (sslh-select) version
# systemd users: don't forget to modify /lib/systemd/system/sslh.service
DAEMON=/usr/sbin/sslh

DAEMON_OPTS="--user sslh --listen 0.0.0.0:443 --ssl 127.0.0.1:777 --ssh 127.0.0.1:109 --openvpn 127.0.0.1:1194 --http 127.0.0.1:80 --pidfile /var/run/sslh/sslh.pid -n"

END

# Restart Service SSLH
echo -e "[ ${BLUE}NOTES${NC} ] Restart Service SSLH"
###############$$$$
service sslh restart
systemctl restart sslh
/etc/init.d/sslh restart
/etc/init.d/sslh status

# setting vnstat
echo -e "[ ${GREEN}INFO${NC} ] install vnstat"
apt -y install vnstat >/dev/null 2>&1
/etc/init.d/vnstat restart
/etc/init.d/vnstat status
apt -y install libsqlite3-dev
wget https://humdi.net/vnstat/vnstat-2.6.tar.gz
tar zxvf vnstat-2.6.tar.gz
cd vnstat-2.6
./configure --prefix=/usr --sysconfdir=/etc && make && make install
cd
vnstat -u -i $NET
sed -i 's/Interface "'""eth0""'"/Interface "'""$NET""'"/g' /etc/vnstat.conf
chown vnstat:vnstat /var/lib/vnstat -R
systemctl enable vnstat
/etc/init.d/vnstat restart
/etc/init.d/vnstat status
rm -f /root/vnstat-2.6.tar.gz
rm -rf /root/vnstat-2.6

mkdir -p /usr/local/geovpn
mkdir -p /etc/geovpn

# install stunnel 5 
echo -e "[ ${GREEN}INFO${NC} ] install stunnel 5 "
cd /root/
wget -q -O stunnel-5.62.zip "https://raw.githubusercontent.com/Jatimpark/multi/main/uye/stunnel-5.62.zip"
unzip -o stunnel-5.62.zip
cd /root/stunnel
chmod +x configure
./configure
make
make install
cd /root
rm -r -f stunnel
rm -f stunnel-5.62.zip
mkdir -p /etc/stunnel5
chmod 644 /etc/stunnel5

# Download Config Stunnel5
echo -e "[ ${BLUE}NOTES${NC} ] Download Config Stunnel5"
cat > /etc/stunnel5/stunnel5.conf <<-END
cert = /etc/stunnel5/stunnel5.pem
client = no
socket = a:SO_REUSEADDR=1
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1

[dropbear]
accept = 222
connect = 127.0.0.1:109

[openssh]
accept = 777
connect = 127.0.0.1:443

[openvpn]
accept = 990
connect = 127.0.0.1:1194

END

# make a certificate
echo -e "[ ${BLUE}NOTES${NC} ] make a certificate "
openssl genrsa -out key.pem 2048
openssl req -new -x509 -key key.pem -out cert.pem -days 1095 \
-subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$commonname/emailAddress=$email"
cat key.pem cert.pem >> /etc/stunnel5/stunnel5.pem

# Service Stunnel5 systemctl restart stunnel5
echo -e "[ ${BLUE}NOTES${NC} ] Service Stunnel5 systemctl restart stunnel5 "
cat > /etc/systemd/system/stunnel5.service << END
[Unit]
Description=Stunnel5 Service
Documentation=https://stunnel.org
Documentation=https://github.com/geovpn
After=syslog.target network-online.target

[Service]
ExecStart=/usr/local/geovpn/stunnel5 /etc/stunnel5/stunnel5.conf
Type=forking

[Install]
WantedBy=multi-user.target
END

# Service Stunnel5 /etc/init.d/stunnel5
echo -e "[ ${BLUE}NOTES${NC} ] Service Stunnel5 /etc/init.d/stunnel5 "
wget -q -O /etc/init.d/stunnel5 "https://raw.githubusercontent.com/Jatimpark/multi/main/uye/stunnel5.init"

# Ubah Izin Akses
echo -e "[ ${BLUE}NOTES${NC} ] Ubah Izin Akses "
chmod 600 /etc/stunnel5/stunnel5.pem
chmod +x /etc/init.d/stunnel5
cp /usr/local/bin/stunnel /usr/local/geovpn/stunnel5

# Remove File
echo -e "[ ${BLUE}NOTES${NC} ] Remove File "
rm -r -f /usr/local/share/doc/stunnel/
rm -r -f /usr/local/etc/stunnel/
rm -f /usr/local/bin/stunnel
rm -f /usr/local/bin/stunnel3
rm -f /usr/local/bin/stunnel4
rm -f /usr/local/bin/stunnel5

# Restart Stunnel 5
echo -e "[ ${BLUE}NOTES${NC} ] Restart Stunnel 5 "
systemctl stop stunnel5
systemctl enable stunnel5
systemctl start stunnel5
systemctl restart stunnel5
/etc/init.d/stunnel5 restart
/etc/init.d/stunnel5 status
/etc/init.d/stunnel5 restart

#OpenVPN
#echo -e "[ ${GREEN}INFO${NC} ] Install OpenVPN"
#wget https://arya1.github.io/multi/uye/vpn.sh &&  chmod +x vpn.sh && ./vpn.sh

# install fail2ban
echo -e "[ ${GREEN}INFO${NC} ] install fail2ban"
apt -y install fail2ban >/dev/null 2>&1

clear
mkdir -p /usr/local/geovpn/
mkdir -p /etc/geovpn/
mkdir -p /etc/systemd/system/
# // Installing ePro WebSocket Proxy
echo -e "[ ${GREEN}INFO${NC} ] Installing ePro WebSocket Proxy"
wget -q -O /usr/local/geovpn/ws-epro "https://raw.githubusercontent.com/Jatimpark/multi/main/uye/ws-epro"
chmod +x /usr/local/geovpn/ws-epro
wget -q -O /etc/geovpn/ws-epro.conf "https://raw.githubusercontent.com/Jatimpark/multi/main/uye/ws-epro.conf"
chmod 644 /etc/geovpn/ws-epro.conf
wget -q -O /etc/systemd/system/ws-epro.service "https://raw.githubusercontent.com/Jatimpark/multi/main/uye/ws-epro.service"
systemctl disable ws-epro
systemctl stop ws-epro
systemctl enable ws-epro
systemctl start ws-epro
systemctl restart ws-epro

clear
# Install BBR
echo -e "[ ${GREEN}INFO${NC} ] Install BBR "
wget https://raw.githubusercontent.com/Jatimpark/multi/main/uye/bbr.sh && chmod +x bbr.sh && ./bbr.sh

#gshshshs
apt install figlet -y
apt install lolcat -y
gem install lolcat

#wget -O ~/menu.zip "https://jaka1m.github.io/project/mantap/menu/menu.zip" >/dev/null 2>&1
#mkdir /root/menu
#7z e  ~/menu.zip -o/root/menu/ >/dev/null 2>&1
#chmod +x /root/menu/*
#mv /root/menu/* /usr/local/sbin/

# banner /etc/issue.net
#echo -e "[ ${GREEN}INFO${NC} ] Install Banner"
#wget -O /etc/issue.net "https://jaka1m.github.io/project/mantap/issue.net"
#echo "Banner /etc/issue.net" >>/etc/ssh/sshd_config
#sed -i 's@DROPBEAR_BANNER=""@DROPBEAR_BANNER="/etc/issue.net"@g' /etc/default/dropbear

# > pasang gotop
sleep 1
clear
#print_install "Memasang Swap 1 Gb"
    gotop_latest="$(curl -s https://api.github.com/repos/xxxserxxx/gotop/releases | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1)"
    gotop_link="https://github.com/xxxserxxx/gotop/releases/download/v$gotop_latest/gotop_v"$gotop_latest"_linux_amd64.deb"
    curl -sL "$gotop_link" -o /tmp/gotop.deb
    dpkg -i /tmp/gotop.deb >/dev/null 2>&1
    
        # > Buat swap sebesar 1G
    dd if=/dev/zero of=/swapfile bs=1024 count=1048576
    mkswap /swapfile
    chown root:root /swapfile
    chmod 0600 /swapfile >/dev/null 2>&1
    swapon /swapfile >/dev/null 2>&1
    sed -i '$ i\/swapfile      swap swap   defaults    0 0' /etc/fstab

# blockir torrent
echo -e "[ ${BLUE}NOTES${NC} ] Blokir torrent "
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
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload

# ipserver
#wget -q -O /etc/ipserver "https://raw.githubusercontent.com/jaka1m/project/main/ssh/ipserver" && bash /etc/ipserver

echo "0 5 * * * root clearlog && reboot" >> /etc/crontab
echo "0 6 * * * root delexp" >> /etc/crontab
# remove unnecessary files
echo -e "[ ${GREEN}INFO${NC} ] remove unnecessary files "
cd
apt autoclean -y
apt -y remove --purge unscd
apt-get -y --purge remove samba*;
apt-get -y --purge remove apache2*;
apt-get -y --purge remove bind9*;
apt-get -y remove sendmail*
apt autoremove -y
# finishing
clear
cd
chown -R www-data:www-data /home/vps/public_html
sleep 1

sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restarting squid "
/etc/init.d/squid restart
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7400 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7500 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7600 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7700 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7800 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7900 --max-clients 500
history -c
echo "unset HISTFILE" >> /etc/profile

cd
rm -f /root/key.pem
rm -f /root/cert.pem
rm -f /root/ssh-vpn.sh
rm -r /root/lolcat

# finihsing
clear
