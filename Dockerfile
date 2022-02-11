FROM ubuntu:20.04
MAINTAINER justinas@eofnet.lt
WORKDIR /root/


RUN apt-get update && ln -fs /usr/share/zoneinfo/Europe/Vilnius /etc/localtime && \
   DEBIAN_FRONTEND=noninteractive  apt-get install -y prosody nginx supervisor

# copy init
COPY files/init.sh /init.sh
# copy supervisor conf
COPY files/supervisor-telegabber.conf /etc/supervisor/conf.d//supervisor-telegabber.conf
# copy libs and files from libs image
COPY --from=telegabber-libs:latest /usr/local/lib/libtd* /usr/local/lib/
COPY --from=telegabber-libs:latest /usr/local/lib/pkgconfig/td* /usr/local/lib/pkgconfig/
COPY --from=telegabber-libs:latest /usr/local/lib/cmake/Td /usr/local/lib/cmake/
COPY --from=telegabber-libs:latest /usr/local/include/td/ /usr/local/include/
# copy telegabber
COPY --from=telegabber-libs:latest /telegabber /root/telegabber

#RUN export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig && pkg-config --variable pc_path pkg-config && \
RUN mkdir -p /var/www/telegabber/content/ && sed -i -e '/\[::\]:80/d' /etc/nginx/sites-enabled/default

# copy telegabber config
COPY files/config.yml /root/telegabber/config.yml
# copy prosody configs
COPY files/component.cfg.lua /etc/prosody/conf.d/component.cfg.lua
COPY files/settings.cfg.lua /etc/prosody/conf.d/settings.cfg.lua
# copy nginx config
COPY files/nginx_host.conf /etc/nginx/sites-enabled/nginx_host.conf

VOLUME ["/var/lib/prosody","/sessions"]

# Configure Services and Port
ENTRYPOINT ["/init.sh"]
 
EXPOSE 5222
EXPOSE 5223
EXPOSE 5269
EXPOSE 80
