#!/bin/sh

# Similar to build-key, but protect the private key
# with a password.

#export KEY_PASSWORD=`/usr/bin/pwgen -s 8 1`
#echo $KEY_PASSWORD > /etc/openvpn/ca/keys/$1.password.txt



export KEY_PASSWORD=$2
echo $KEY_PASSWORD


cd /etc/openvpn/ca
. ./vars

echo $KEY_PASSWORD > /etc/openvpn/ca/keys/$1.password.txt

export EASY_RSA="${EASY_RSA:-.}"
#"$EASY_RSA/pkitool" --batch --pass $*
"$EASY_RSA/pkitool" --batch --pass $1


cd /etc/openvpn/ca/keys

cat /etc/openvpn/ca/vpn_TS_conf.ovpn > ./conf/$1_TS.ovpn

echo "<ca>" >> ./conf/$1_TS.ovpn
cat ca.crt  >> ./conf/$1_TS.ovpn
echo "</ca>" >> ./conf/$1_TS.ovpn

echo "<cert>" >> ./conf/$1_TS.ovpn
cat $1.crt  >> ./conf/$1_TS.ovpn
echo "</cert>" >> ./conf/$1_TS.ovpn

echo "<key>" >> ./conf/$1_TS.ovpn
cat $1.key  >> ./conf/$1_TS.ovpn
echo "</key>" >> ./conf/$1_TS.ovpn

echo "<dh>" >> ./conf/$1_TS.ovpn
cat dh2048.pem  >> ./conf/$1_TS.ovpn
echo "</dh>" >> ./conf/$1_TS.ovpn


cat /etc/openvpn/ca/vpn_FULL_TCP_conf.ovpn > ./conf/$1_FULL.ovpn

echo "<ca>" >> ./conf/$1_FULL.ovpn
cat ca.crt  >> ./conf/$1_FULL.ovpn
echo "</ca>" >> ./conf/$1_FULL.ovpn

echo "<cert>" >> ./conf/$1_FULL.ovpn
cat $1.crt  >> ./conf/$1_FULL.ovpn
echo "</cert>" >> ./conf/$1_FULL.ovpn

echo "<key>" >> ./conf/$1_FULL.ovpn
cat $1.key  >> ./conf/$1_FULL.ovpn
echo "</key>" >> ./conf/$1_FULL.ovpn

echo "<dh>" >> ./conf/$1_FULL.ovpn
cat dh2048.pem  >> ./conf/$1_FULL.ovpn
echo "</dh>" >> ./conf/$1_FULL.ovpn


#/usr/bin/mailx -r sistema@pippo.it -s "VPN per $1 con password" -a /etc/openvpn/ca/keys/$1.ovpn sistema@pippo.it < /etc/openvpn/ca/keys/$1.password.txt
