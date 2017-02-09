FROM linuxserver/deluge
MAINTAINER n3mur1t0r <n3mur1t0r@gmail.com>

RUN \
# install build packages
apk add --no-cache --virtual=build-dependencies \
       py2-pip && \

#install pip packages
pip install --no-cache-dir -U \
       pip && \
pip install --no-cache-dir -U \
       flexget && \

#cleanup
apk del --purge \
       build-dependencies && \
rm -rf \
       /root/.cache

#volume
VOLUME /flexcfg
