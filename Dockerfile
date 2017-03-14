FROM lsiobase/alpine:3.5
LABEL org.freenas.interactive="false"                       \
      org.freenas.version="1"                          \
      org.freenas.upgradeable="true"                        \
      org.freenas.expose-ports-at-host="true"               \
      org.freenas.autostart="true"                          \
      org.freenas.web-ui-protocol="http"                    \
      org.freenas.web-ui-port=8112                          \
      org.freenas.web-ui-path=""                            \
      org.freenas.port-mappings="8112:8112/tcp,58846:58846/tcp,58946:58946/tcp,58946:58946/udp" \
      org.freenas.volumes="[						                    \
          {							                                    \
              \"name\": \"/config\",					              \
              \"descr\": \"Config storage space\"		        \
          },							                                  \
          {							                                    \
              \"name\": \"/downloads\",					            \
              \"descr\": \"Downloads volume\"				        \
          },						                                    \
          {                                                 \
              \"name\": \"/flexcfg\",                       \
              \"descr\": \"FlexGet config directory\"       \
          }                                                 \
      ]" 								                                    \
      org.freenas.settings="[ 					                    \
          {							                                    \
              \"env\": \"TZ\",					                    \
              \"descr\": \"Timezone - eg Europe/London\",		\
              \"optional\": true					                  \
          },							                                  \
          {							                                    \
              \"env\": \"PGID\",					                  \
              \"descr\": \"GroupID\",					              \
              \"optional\": false					                  \
          },							                                  \
          {							                                    \
              \"env\": \"PUID\",					                  \
              \"descr\": \"UserID\",					              \
              \"optional\": false					                  \
         }							                                    \
      ]"

# environment variables
ENV PYTHON_EGG_CACHE="/config/plugins/.python-eggs"

# install runtime packages
RUN \
 apk add --no-cache \
  ca-certificates \
  libressl2.4-libssl \
  p7zip \
  unrar \
  unzip && \
 apk add --no-cache \
  --repository http://nl.alpinelinux.org/alpine/edge/testing \
  deluge && \

# install build packages
 apk add --no-cache --virtual=build-dependencies \
  g++ \
  gcc \
  libffi-dev \
  libressl-dev \
  py2-pip \
  python2-dev && \

# install pip packages
 pip install --no-cache-dir -U \
  incremental \
  pip && \
 pip install --no-cache-dir -U \
  crypto \
  mako \
  markupsafe \
  pyopenssl \
  service_identity \
  six \
  twisted \
  zope.interface \
  flexget && \

# cleanup
 apk del --purge \
  build-dependencies && \
 rm -rf \
  /root/.cache

# add local files
COPY root/ /

# ports and volumes
EXPOSE 8112 58846 58946 58946/udp
VOLUME /config /downloads /flexcfg
