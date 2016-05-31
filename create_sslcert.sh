#!/bin/sh
if [ -z $1 ]
then
   echo 'enter arg'
   exit
fi

if [ -z $2 ]
then
   echo 'enter your mail'
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
mail=$2
webserver_path='/opt/nginx/cfg'
mkdir $webserver_path/letencrept
cd $_
wget https://dl.eff.org/certbot-auto
chmod a+x ./certbot-auto
ays stop -n nginx    #used to stop nginx in JS7
./certbot-auto certonly --standalone --email $mail -d $environment -d ovs-$environment -d novnc-$environment -d defense-$environment
if [ -! -d $webserver_path/ssl ]
then
    mkdir $webserver_path/ssl
    cd $_
else
    cd /$webserver_path/ssl
fi
cp /etc/letsencrypt/archive/$environment/* .
echo '[*] Certificate path /etc/nginx/ssl/cert1.pem'
echo '[*] Certificate key /etc/nginx/ssl/privkey1.pem'

sed -i 's/\/opt\/nginx\/cfg\/ssl\/demo\.greenitglobe\.com\.crt/\/opt\/nginx\/cfg\/ssl\/cert1\.pem/g' /opt/nginx/cfg/sites-enabled/ovc
sed -i 's/\/opt\/nginx\/cfg\/ssl\/demo\.greenitglobe\.com\.key/\/opt\/nginx\/cfg\/ssl\/privkey1\.pem/g' /opt/nginx/cfg/sites-enabled/ovc
ays start -n nginx   #used to start nginx in JS7
