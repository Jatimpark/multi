#!/bin/bash
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
CHATID="1210833546"
TIMES="10"
BG='\e[1;97;101m'
domain=$(cat /etc/xray/domain)
clear
red() { echo -e "\\033[32;1m${*}\\033[0m"; }
clear
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "${BG}USERNAME          EXP DATE    STATUS AKUN \e[0m"
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
while read expired
do
AKUN="$(echo $expired | cut -d: -f1)"
ID="$(echo $expired | grep -v nobody | cut -d: -f3)"
exp="$(chage -l $AKUN | grep "Account expires" | awk -F": " '{print $2}')"
status="$(passwd -S $AKUN | awk '{print $2}' )"
if [[ $ID -ge 1000 ]]; then
if [[ "$status" = "L" ]]; then
printf "%-17s %2s %-17s %2s \n" "$AKUN" "$exp     " "LOCKED" 
else
printf "%-17s %2s %-17s %2s \n" "$AKUN" "$exp     " "AKTIF" 
fi
fi
done < /etc/passwd
JUMLAH="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "${BG}TOTAL AKUN SSH   :              $JUMLAH USER   \e[0m"
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
read -p "   Username : " USERSSH

if [ -z $USERSSH ]; then
    echo -e "Username cannot be empty "
else
    if getent passwd $USERSSH >/dev/null 2>&1; then
        userdel $USERSSH >/dev/null 2>&1
        sed -i "/^### $user/d" /etc/ssh/.ssh.db
        sed -i "/^#ssh# $USERSSH/d" /etc/ssh/.ssh.db
echo -e "                   User $USERSSH was removed."
    else
        echo -e "Failure: User $USERSSH Not Exist."
    fi
fi
    clear
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " \e[1;97;101m          DELETE SSH ACCOUNT           \E[0m"
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" 
echo -e "${BIGreen}Client Name : $USERSSH ${NC} "
echo -e "${BIGreen}Exfired On  : $exp ${NC}"
echo -e "${BIGreen}Script Arya : 087721815317 ${NC}"
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
read -n 1 -s -r -p "Press [ Enter ] to back on menu"
ssh
