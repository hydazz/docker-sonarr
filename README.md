## Alpine Edge fork of [linuxserver/docker-sonarr](https://github.com/linuxserver/docker-sonarr/)
[Sonarr](https://sonarr.tv/) (formerly NZBdrone) is a PVR for usenet and bittorrent users. It can monitor multiple RSS feeds for new episodes of your favorite shows and will grab, sort and rename them. It can also be configured to automatically upgrade the quality of files already downloaded when a better quality format becomes available.

[![docker hub](https://img.shields.io/badge/docker_hub-link-blue?style=for-the-badge&logo=docker)](https://hub.docker.com/repository/docker/vcxpz/sonarr) ![docker image size](https://img.shields.io/docker/image-size/vcxpz/sonarr?style=for-the-badge&logo=docker) [![auto build](https://img.shields.io/badge/auto_build-daily-blue?style=for-the-badge&logo=docker?color=d1aa67)](https://github.com/hydazz/docker-sonarr/actions?query=workflow%3A%22Cron+Update+CI%22)

## Version Information
![alpine](https://img.shields.io/badge/alpine-edge-0D597F?style=for-the-badge&logo=alpine-linux) ![s6overlay](https://img.shields.io/badge/s6_overlay-2.1.0.2-blue?style=for-the-badge) ![mono](https://img.shields.io/badge/mono-6.12.0.107-blue?style=for-the-badge) ![sonarr](https://img.shields.io/badge/sonarr-3.0.4.1042-blue?style=for-the-badge)

## Usage
```
docker run -d \
  --name=sonarr \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Australia/Melbourne \
  -e UMASK_SET=022 `#optional` \
  -e DEBUG=true/false `#optional` \
  -p 8989:8989 \
  -v <path to appdata>:/config \
  -v <path to tv>:/tv \
  -v <path to downloads>:/downloads \
  --restart unless-stopped \
  vcxpz/sonarr
```

## Credits
* [spritsail/sonarr](https://github.com/spritsail/sonarr) for the `HEALTHCHECK` command
* [hotio](https://github.com/hotio) for the `redirect_cmd` function

## Todo
* Nothing, everything works 🙂
