FROM vcxpz/baseimage-alpine-mono:latest

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Sonarr version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="hydaz"

# environment settings
ARG BRANCH="develop"

RUN set -xe && \
	echo "**** install build packages ****" && \
	apk add --no-cache --virtual=build-dependencies \
		curl \
		jq && \
	echo "**** install runtime packages ****" && \
	apk add --no-cache \
		libmediainfo \
		xmlstarlet && \
	echo "**** install sonarr ****" && \
	if [ -z ${VERSION+x} ]; then \
		VERSION=$(curl -sX GET http://services.sonarr.tv/v1/releases | \
			jq -r ".[] | select(.branch==\"$BRANCH\") | .version"); \
	fi && \
	mkdir -p /app/sonarr/bin && \
	curl -o \
		/tmp/sonarr.tar.gz -L \
		"https://download.sonarr.tv/v3/${BRANCH}/${VERSION}/Sonarr.${BRANCH}.${VERSION}.linux.tar.gz" && \
	tar xzf \
		/tmp/sonarr.tar.gz -C \
		/app/sonarr/bin --strip-components=1 && \
	printf "UpdateMethod=docker\nBranch=${BRANCH}\n" >/app/sonarr/package_info && \
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
