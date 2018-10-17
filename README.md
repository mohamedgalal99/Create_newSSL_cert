# Create_newSSL_cert 4FREE

- Sponsor for this certificate is Let's Encrypt (https://letsencrypt.org)
- This create ssl certificate which valid for 90 day
- Your domain must be registered and be A Record in DNS

#Note
In line 34, change -d args to reflect ur domain

##Ex:
> chmod +x create_sslcert.sh
> ./create_sslcert.sh example.com admin@example.com
# for wild ssl cert
>  ./certbot-auto certonly --manual -d *.demo.greenitglobe.com --agree-tos --manual-public-ip-logging-ok --preferred-challenges dns-01 --server https://acme-v02.api.letsencrypt.org/directory
  certbot renew --dry-run
  
  
  # Check if certificate is match with key 
> openssl x509 -noout -modulus -in athenadatacentres.com.crt | openssl md5

> openssl rsa -noout -modulus -in athenadatacentres.com.key | openssl md5

if both have same md5sum, it's goooooooooooood :)
