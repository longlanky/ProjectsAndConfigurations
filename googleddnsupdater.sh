myip=$(curl -s https://ipinfo.io/ip)
ddnsip=$(perl -MSocket -E 'say inet_ntoa(inet_aton("{FQDN}"))')

if [[ $myip != $ddnsip ]]; then
    curl -X POST "https://{GOOGLEDDNSUSERNAME}:{GOOGLEDDNSPASSWORD}@domains.google.com/nic/update?hostname={FQSDN}&myip=$myip)"
fi
