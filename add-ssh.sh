#!/bin/bash
clear
red() { echo -e "\\033[32;1m${*}\\033[0m"; }
GARIS="\033[1;36m"
NC="\033[0m"
AKUN="AKUN SSH"
TIMES="10"
#CHATID="1210833546"
#KEY="6006599143:AAEgstCAioq35JgX97HaW_G3TAkLKzLZS_w"
#URL="https://api.telegram.org/bot$KEY/sendMessage"
hariini=`date -d "0 days" +"%Y-%m-%d"`
clear
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " \e[1;97;101m          SSH OVPN ACCOUNT            \E[0m"
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
read -p "Username : " LOGIN
read -p "Password : " PASSWD
read -p "Expired (hari): " EXPIRED
#read -p "Owner : " OWNER
#read -p "Input Id Grup (-1001911868043) : " CHATIDGC
IP=$(curl -sS ifconfig.me)
CITY=$(cat /etc/xray/city)
PUB=$( cat /etc/slowdns/server.pub )
NS=`cat /etc/xray/dns`
domain=`cat /etc/xray/domain`
useradd -e `date -d "$EXPIRED days" +"%Y-%m-%d"` -s /bin/false -M $LOGIN
exp="$(chage -l $LOGIN | grep "Account expires" | awk -F": " '{print $2}')"
echo -e "$PASSWD\n$PASSWD\n"|passwd $LOGIN &> /dev/null

if [[ ${c} != "0" ]]; then
  echo "${d}" >/etc/ssh/${LOGIN}
fi
DATADB=$(cat /etc/ssh/.ssh.db | grep "^#ssh#" | grep -w "${LOGIN}" | awk '{print $2}')
if [[ "${DATADB}" != '' ]]; then
  sed -i "/\b${LOGIN}\b/d" /etc/ssh/.ssh.db
fi
echo "#ssh# ${LOGIN} " >>/etc/ssh/.ssh.db

cat > /var/www/html/ssh-$LOGIN.txt <<-END
=======================
P R O J E C T  O F
=======================
https://github.com/Jatimpark/multi
=======================
Format SSH OVPN Account
=======================

Username         : $LOGIN
Password         : $PASSWD
Expired          : $exp
_______________________________
IP               : $IP
Host             : $domain
Host Slowdns     : ${NS}
Pub Key          : ${PUB}
Location         : $CITY
Port OpenSSH     : 443, 80, 22
Port Dropbear    : 443, 109
Port Dropbear WS : 443, 109
Port SSH WS      : 80
Port SSH SSL WS  : 443
Port SSL/TLS     : 443
Port OVPN WS SSL : 443
Port OVPN SSL    : 1194
Port OVPN TCP    : 1194
Port OVPN UDP    : 2200
Proxy Squid 1    : 3128
Proxy Squid 2    : 8000
Proxy Squid 3    : 8080
BadVPN UDP       : 7100, 7300, 7300
_______________________________
Payload WSS: GET wss://BUG.COM/ HTTP/1.1[crlf]Host: $domain[crlf]Upgrade: websocket[crlf][crlf]
_______________________________
OpenVPN WS SSL : https://$domain:81/"$domain"-ws-ssl.ovpn
OpenVPN SSL : https://$domain:81/"$domain"-ssl.ovpn
OpenVPN TCP : https://$domain:81/"$domain"-tcp.ovpn
OpenVPN UDP : https://$domain:81/"$domain"-udp.ovpn
_______________________________

END
TRX="
<code>INFO MASKU -Transaksi</code>
<code>────────────────────</code>
<b>  ⚠️TRANSAKSI SSH OVPN⚠️      </b>
<code>────────────────────</code>
<code>🌟Owner   : $OWNER</code>
<code>🌟Detail  : $AKUN</code>
<code>🌟Created  : $hariini</code>
<code>🌟Exfired  : $exp</code>
<code>🌟Server  : $domain</code>
<code>────────────────────</code>
<i>Notifikasi Via RstoreBOT</i>
<b>Tele : @kytxz</b>
"
TEXT="
<code>──────────────────────────</code>
<code>      ⚠️SSH OVPN Account⚠️     </code>
<code>──────────────────────────</code>
<code>Username         : $LOGIN</code>
<code>Password         : $PASSWD</code>
<code>Created          : $hariini</code>
<code>Expired          : $exp</code>
<code>──────────────────────────</code>
<code>IP               : $IP</code>
<code>Host             : $domain</code>
<code>Host Slowdns     : ${NS}</code>
<code>Pub Key          : ${PUB}</code>
<code>Location         : $CITY</code>
<code>Port Udp         : 1-65545</code>
<code>Port OpenSSH     : 443, 80, 22</code>
<code>Port Dropbear    : 443, 109</code>
<code>Port Dropbear WS : 443, 109</code>
<code>Port DNS         : 443, 53, 22</code>
<code>Port SSH WS      : 80 </code>
<code>Port SSH SSL WS  : 443</code>
<code>Port SSL/TLS     : 443</code>
<code>Port OVPN WS SSL : 443</code>
<code>Port OVPN SSL    : 443</code>
<code>Port OVPN TCP    : 443, 1194</code>
<code>Port OVPN UDP    : 2200</code>
<code>Proxy Squid      : 3128</code>
<code>BadVPN UDP       : 7100, 7300, 7300</code>
<code>──────────────────────────</code>
<code>Payload WSS      : </code><code>GET wss://BUG.COM/ HTTP/1.1[crlf]Host: $domain[crlf]Upgrade: websocket[crlf][crlf]</code>
<code>──────────────────────────</code>
<code>OpenVPN WS SSL   : </code>https://$domain:81/"$domain"-ws-ssl.ovpn
<code>OpenVPN SSL      : </code>https://$domain:81/"$domain"-ssl.ovpn
<code>OpenVPN TCP      : </code>https://$domain:81/"$domain"-tcp.ovpn
<code>OpenVPN UDP      : </code>https://$domain:81/"$domain"-udp.ovpn
<code>──────────────────────────</code>
<code>Save Link Account: </code>https://$domain:81/ssh-$LOGIN.txt
<code>──────────────────────────</code>
"
curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL
clear
curl -s --max-time $TIMES -d "chat_id=$CHATIDGC&disable_web_page_preview=1&text=$TRX&parse_mode=html" $URL
clear
clear
echo -e "${GARIS}◇━━━━ Account Info ━━━━◇${NC}"
echo -e "Username	: $LOGIN"
echo -e "Password	: $PASSWD"
echo -e "Expired         : $(date +%d/%m/%y -d "$exp")"
echo -e "${GARIS}◇━━━━━━━━━━━━━━━━━◇${NC}"
echo -e "Host CF         : $domain"
echo -e "IP              : $IP"
echo -e "ISP		: $CITY"
echo -e "Host Bug	: bug.$domain"
echo -e "Note: bug bisa di ganti bebas"
echo -e "${GARIS}◇━━━━━━ Non TLS ━━━━━◇${NC}"
echo -e "OpenSSH         :143,80,22"
echo -e "Dropbear	:443,109"
echo -e "WS Dropbear	:80,143"
echo -e "${GARIS}◇━━━━━ SSL / TLS ━━━━━◇${NC}"
echo -e "OpenSSH         :443,22"
echo -e "Dropbear	:143,777"
echo -e "Ws Dropbear	:443"
echo -e "${GARIS}◇━━━━ Mode Proxy ━━━━━◇${NC}"
echo -e "OHP OpenSSH	:8080"
echo -e "OHP Dropbear	:8181"
echo -e "Squid     	:3128"
echo -e "Socks5	        :1080"
echo -e "${GARIS}◇━━━━━ Slow DNS ━━━━━◇${NC}"
echo -e "NS SlowDNS      : $NS"
echo -e "Port SlowDNS    :22 / Bebas"
echo -e "Pubkey SlowDNS  : $PUB"
echo -e "${GARIS}◇━━━━━ OpenVPN ━━━━━◇${NC}"
echo -e "OpenVPN WS SSL  : https://$domain:81/"$domain"-ws-ssl.ovpn"
echo -e "OpenVPN SSL     : https://$domain:81/"$domain"-ssl.ovpn"
echo -e "OpenVPN TCP     : https://$domain:81/"$domain"-tcp.ovpn"
echo -e "OpenVPN UDP     : https://$domain:81/"$domain"-udp.ovpn"
echo -e "${GARIS}◇━━━━━━━━━━━━━━━━━◇${NC}"
echo -e "UDPcustom	:1-65535"
echo -e "BadVPN/UDPGW	:7200,7300"
echo -e "Reboot VPS	: 00.00 (GMT+7)"
echo -e "${GARIS}◇━━━━━━━━━━━━━━━━━◇${NC}"
echo -e "GET / HTTP/1.1[crlf]Host: [host][crlf]User-Agent: [ua][crlf]Upgrade: websocket[crlf][crlf]"
echo -e "${GARIS}◇━━━━━━━━━━━━━━━━━◇${NC}"
echo -e "" 
read -n 1 -s -r -p "Press [ Enter ] to back on menu"
ssh
