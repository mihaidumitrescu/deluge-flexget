FROM linuxserver/deluge
MAINTAINER Alexandru Mirica <n3mur1t0r@gmail.com>

# install flexget
RUN \
 pip install --no-cache-dir -U \
        flexget && \

#volumes
VOLUME /flexcfg

