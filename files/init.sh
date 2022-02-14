#!/bin/sh
[ -d /usr/local/go ] && export PATH=$PATH:/usr/local/go/bin

[ -d "/run/prosody" ] || mkdir /run/prosody


# generate configs
ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime
sed -i -e s/API_ID_KEY/${TELEGRAM_API_ID}/g /root/telegabber/config.yml
sed -i -e s/API_ID_HASH/${TELEGRAM_API_HASH}/g /root/telegabber/config.yml
sed -i -e s/LINK_HOST/${LINK_HOST}/g /root/telegabber/config.yml
sed -i -e s/BRIDGE_HOST/telegabber.${MAIN_HOST}/g /root/telegabber/config.yml
sed -i -e s/FILES_HOST/${FILES_HOST}/g /root/telegabber/config.yml
sed -i -e s/LINK_HOST/${LINK_HOST}/g /etc/nginx/sites-enabled/nginx_host.conf
sed -i -e s/BRIDGE_HOST/telegabber.${MAIN_HOST}/g /etc/prosody/conf.d/component.cfg.lua
sed -i -e s/localhost/${MAIN_HOST}/g /etc/prosody/conf.d/localhost.cfg.lua
sed -i -e 's/user www-data/user root/g' /etc/nginx/nginx.conf

# generate ssl

[ -d /etc/prosody/certs/${MAIN_HOST}.crt ] || cd /etc/prosody/certs && openssl req -x509 -nodes -newkey rsa:2048 \
  -days 3660 \
  -subj "/C=XX/ST=XXXX/L=XXXX/O=XXXX/OU=XXXX/CN=${MAIN_HOST}/emailAddress=postmaster@${MAIN_HOST}" \
  -addext "subjectAltName = DNS:${MAIN_HOST}, DNS:telegabber.${MAIN_HOST}, DNS:${FILES_HOST}" \
  -keyout ${MAIN_HOST}.key \
  -out ${MAIN_HOST}.crt

/usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf &

tail -F /dev/null
