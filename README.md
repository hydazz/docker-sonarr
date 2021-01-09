## docker-sonarr
[![docker hub](https://img.shields.io/badge/docker_hub-link-blue?style=for-the-badge&logo=docker)](https://hub.docker.com/repository/docker/vcxpz/sonarr) ![docker image size](https://img.shields.io/docker/image-size/vcxpz/sonarr?style=for-the-badge&logo=docker) [![auto build](https://img.shields.io/badge/docker_builds-automated-blue?style=for-the-badge&logo=docker?color=d1aa67)](https://github.com/hydazz/docker-sonarr/actions?query=workflow%3A"Auto+Builder+CI")

Fork of [linuxserver/docker-sonarr](https://github.com/linuxserver/docker-sonarr/)

[Sonarr](https://sonarr.tv/) is a PVR for Usenet and BitTorrent users. It can monitor multiple RSS feeds for new episodes of your favorite shows and will grab, sort and rename them. It can also be configured to automatically upgrade the quality of files already downloaded when a better quality format becomes available.

## Version Information
![alpine](https://img.shields.io/badge/alpine-edge-0D597F?style=for-the-badge&logo=alpine-linux) ![s6overlay](https://img.shields.io/badge/s6_overlay-2.1.0.2-blue?style=for-the-badge) ![mono](https://img.shields.io/badge/mono-6.12.0.107-blue?style=for-the-badge) ![sonarr](https://img.shields.io/badge/sonarr-3.0.4.1059-blue?style=for-the-badge)

**[See here for a list of packages](https://github.com/hydazz/docker-sonarr/blob/main/package_versions.txt)**

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
[![template](https://img.shields.io/badge/unraid_template-ff8c2f?style=for-the-badge&logo=docker?color=d1aa67)](https://github.com/hydazz/docker-templates/blob/main/hydaz/sonarr.xml)

## New Environment Variables
### Debug
| Name | Description | Default Value |
|-|-|-|
| `DEBUG` | set `true` to display errors in the Docker logs. When set to `false` the Docker log is completely muted. | `false` |

**See other variables on the official [README](https://github.com/linuxserver/docker-sonarr/)**

## Upgrading Sonarr
To upgrade, all you have to do is pull our latest Docker image. We automatically check for Sonarr updates daily so there may be some delay when an update is released to when the image is updated.

## Credits
* [spritsail/sonarr](https://github.com/spritsail/sonarr) for the `HEALTHCHECK` command
* [hotio](https://github.com/hotio) for the `redirect_cmd` function
