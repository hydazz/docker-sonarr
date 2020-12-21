FROM vcxpz/baseimage-mono

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Fork of Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="Alex Hyde"

# environment settings
ARG SONARR_BRANCH
ARG SONARR_VERSION
ENV XDG_CONFIG_HOME="/config/xdg"

RUN \
 echo "**** install sonarr ****" && \
 mkdir -p /app/sonarr/bin && \
 curl -o \
	/tmp/sonarr.tar.gz -L \
	"https://download.sonarr.tv/v3/${SONARR_BRANCH}/${SONARR_VERSION}/Sonarr.${SONARR_BRANCH}.${SONARR_VERSION}.linux.tar.gz" && \
 tar xzf \
	/tmp/sonarr.tar.gz -C \
	/app/sonarr/bin --strip-components=1 && \
 printf "UpdateMethod=docker\nBranch=${SONARR_BRANCH}\n" > /app/sonarr/package_info && \
 echo "**** cleanup ****" && \
 find /app/sonarr/bin -name '*.mdb' -delete && \
 find /app/sonarr/bin/UI -name '*.map' -delete && \
 rm -rf \
	/app/sonarr/bin/Sonarr.Update \
     /app/sonarr/bin/UI/Content/_output \
	/tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 8989
VOLUME /config
