FROM binhex/arch-int-vpn:latest
LABEL org.opencontainers.image.authors="binhex"

# additional files
##################

# add supervisor conf file for app
ADD build/*.conf /etc/supervisor/conf.d/

# add bash scripts to install app
ADD build/root/*.sh /root/

# add run bash scripts
ADD run/nobody/*.sh /home/nobody/

# install app
#############

# make executable and run bash scripts to install app
RUN chmod +x /root/*.sh /home/nobody/*.sh && \
	/bin/bash /root/install.sh

# docker settings
#################

# map /config to host defined config path (used to store configuration from app)
VOLUME /config

# map /data to host defined data path (used for watched/blackhole)
VOLUME /data

# expose port for privoxy
EXPOSE 8118
EXPOSE 9117

# set permissions
#################

# run script to set uid, gid and permissions
CMD ["/bin/bash", "/usr/local/bin/init.sh"]