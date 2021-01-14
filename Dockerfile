FROM vcxpz/baseimage-alpine-mono:latest

# set version label
ARG BUILD_DATE
ARG SONARR_RELEASE
LABEL build_version="Sonarr version:- ${SONARR_RELEASE} Build-date:- ${BUILD_DATE}"
LABEL maintainer="hydaz"

# environment settings
ARG SONARR_BRANCH
ENV XDG_CONFIG_HOME="/config/xdg"

RUN set -xe && \
   echo "**** install build packages ****" && \
   apk add --no-cache --virtual=build-dependencies \
      curl && \
   echo "**** install runtime packages ****" && \
   apk add --no-cache --upgrade \
      libmediainfo \
      xmlstarlet && \
   echo "**** install sonarr ****" && \
   mkdir -p /app/sonarr/bin && \
   curl -o \
      /tmp/sonarr.tar.gz -L \
      "https://download.sonarr.tv/v3/${SONARR_BRANCH}/${SONARR_RELEASE}/Sonarr.${SONARR_BRANCH}.${SONARR_RELEASE}.linux.tar.gz" && \
   tar xzf \
      /tmp/sonarr.tar.gz -C \
      /app/sonarr/bin --strip-components=1 && \
   printf "UpdateMethod=docker\nBranch=${SONARR_BRANCH}\n" > /app/sonarr/package_info && \
   echo "**** cleanup ****" && \
   apk del --purge \
      build-dependencies && \
   find /app/sonarr/bin/ -name '*.mdb' -delete && \
   rm -rf \
      /app/sonarr/bin/Sonarr.Update \
      /tmp/*

# add local files
COPY root/ /

# sonarr healthcheck
HEALTHCHECK --start-period=10s --timeout=5s \
   CMD wget -qO /dev/null 'http://localhost:8989/api/system/status' \
      --header "x-api-key: $(xmlstarlet sel -t -v '/Config/ApiKey' /config/config.xml)"

# ports and volumes
EXPOSE 8989
VOLUME /config
