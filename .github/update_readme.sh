#!/bin/bash

MONO=$(grep <package_versions.txt -E "mono-runtime.*?-" | sed -n 1p | cut -c 14- | sed -E 's/-r.*//g')

sed -i -E \
	-e "s/mono-.*?-blue/mono-${MONO}-blue/g" \
	-e "s/sonarr-.*?-blue/sonarr-${APP_VERSION}-blue/g" \
	README.md
