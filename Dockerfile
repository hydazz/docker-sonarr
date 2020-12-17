FROM vcxpz/baseimage-mono:alpine

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Split of Linuxserver.io version: ${VERSION} Build-date: ${BUILD_DATE}"
LABEL maintainer="hydazz"

# environment settings
ARG SONARR_BRANCH
ARG SONARR_VERSION
ENV XDG_CONFIG_HOME="/config/xdg"

RUN \
 echo "**** install packages ****" && \
 apk add --no-cache \
  curl \
  icu-libs \
  libintl \
	libmediainfo \
  sqlite-libs && \
 echo "**** install sonarr ****" && \
 mkdir -p /app/sonarr/bin && \
 curl -o \
	/tmp/sonarr.tar.gz -L \
	"https://download.sonarr.tv/v3/${SONARR_BRANCH}/${SONARR_VERSION}/Sonarr.${SONARR_BRANCH}.${SONARR_VERSION}.linux.tar.gz" && \
 tar xf \
	/tmp/sonarr.tar.gz -C \
	/app/sonarr/bin --strip-components=1 && \
 echo "UpdateMethod=docker\nBranch=${SONARR_BRANCH}\nPackageVersion=${VERSION}\nPackageAuthor=linuxserver.io" > /app/sonarr/package_info && \
 echo "**** cleanup ****" && \
 rm -rf \
  /app/sonarr/bin/Sonarr.Update \
  /tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 8989
VOLUME /config
