#!/bin/sh
if [ -z $1 ]
then
   echo 'enter arg'
   exit
fi

if [ `dig $1 CNAME +short` ]
then
   echo 'This Entry is CNAME in DNS, we accept A records only'
   exit
fi

if [ -z `dig $1 +short` ]
then
   echo "Can't find this domain"
   exit
fi

environment=$1
mkdir /opt/nginx/letencrept
cd $_
wget https://dl.eff.org/certbot-auto
chmod a+x ./certbot-auto
ays stop -n nginx
./certbot-auto certonly --standalone --email galalm@greenitglobe.com -d $environment -d ovs-$environment -d novnc-$environment -d defense-$environment
mkdir /opt/nginx/cfg/ssl/new
cd $_
cp /etc/letsencrypt/archive/$environment/* .
sed -i 's/\/opt\/nginx\/cfg\/ssl\/demo\.greenitglobe\.com\.crt/\/opt\/nginx\/cfg\/ssl\/new\/cert1\.pem/g' /opt/nginx/cfg/sites-enabled/ovc
sed -i 's/\/opt\/nginx\/cfg\/ssl\/demo\.greenitglobe\.com\.key/\/opt\/nginx\/cfg\/ssl\/new\/privkey1\.pem/g' /opt/nginx/cfg/sites-enabled/ovc
ays start -n nginx
