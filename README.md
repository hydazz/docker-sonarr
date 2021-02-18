## docker-sonarr

[![docker hub](https://img.shields.io/badge/docker_hub-link-blue?style=for-the-badge&logo=docker)](https://hub.docker.com/r/vcxpz/sonarr) ![docker image size](https://img.shields.io/docker/image-size/vcxpz/sonarr?style=for-the-badge&logo=docker) [![auto build](https://img.shields.io/badge/docker_builds-automated-blue?style=for-the-badge&logo=docker?color=d1aa67)](https://github.com/hydazz/docker-sonarr/actions?query=workflow%3A"Auto+Builder+CI") [![codacy branch grade](https://img.shields.io/codacy/grade/2a0ea72f05114ed5add23ea922b7bcb3/main?style=for-the-badge&logo=codacy)](https://app.codacy.com/gh/hydazz/docker-sonarr)

Fork of [linuxserver/docker-sonarr](https://github.com/linuxserver/docker-sonarr/)

[Sonarr](https://sonarr.tv/) is a PVR for Usenet and BitTorrent users. It can monitor multiple RSS feeds for new episodes of your favorite shows and will grab, sort and rename them. It can also be configured to automatically upgrade the quality of files already downloaded when a better quality format becomes available.

## Usage

```bash
docker run -d \
  --name=sonarr \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Australia/Melbourne \
  -e DEBUG=true/false #optional \
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

| Name    | Description                                                                                              | Default Value |
| ------- | -------------------------------------------------------------------------------------------------------- | ------------- |
| `DEBUG` | set `true` to display errors in the Docker logs. When set to `false` the Docker log is completely muted. | `false`       |

**See other variables on the official [README](https://github.com/linuxserver/docker-sonarr/)**

## Upgrading Sonarr

To upgrade, all you have to do is pull the latest Docker image. We automatically check for Sonarr updates daily so there may be some delay when an update is released to when the image is updated.

## Credits

-   [spritsail/sonarr](https://github.com/spritsail/sonarr) for the `HEALTHCHECK` command
-   [hotio](https://github.com/hotio) for the `redirect_cmd` function

## Fixing Appdata Permissions

If you ever accidentally screw up the permissions on the appdata folder, run `fix-perms` within the container. This will restore most of the files/folders with the correct permissions.
