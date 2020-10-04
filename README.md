[<img src="https://hotio.dev/img/unpackerr.png" alt="logo" height="130" width="130">](https://github.com/davidnewhall/unpackerr)

[![GitHub Source](https://img.shields.io/badge/github-source-ffb64c?style=flat-square&logo=github&logoColor=white)](https://github.com/docker-hotio/docker-unpackerr)
[![GitHub Registry](https://img.shields.io/badge/github-registry-ffb64c?style=flat-square&logo=github&logoColor=white)](https://github.com/users/hotio/packages/container/package/unpackerr)
[![Docker Pulls](https://img.shields.io/docker/pulls/hotio/unpackerr?color=ffb64c&style=flat-square&label=pulls&logo=docker&logoColor=white)](https://hub.docker.com/r/hotio/unpackerr)
[![Discord](https://img.shields.io/discord/610068305893523457?style=flat-square&color=ffb64c&label=discord&logo=discord&logoColor=white)](https://hotio.dev/discord)
[![Upstream](https://img.shields.io/badge/upstream-project-ffb64c?style=flat-square)](https://github.com/davidnewhall/unpackerr)
[![Website](https://img.shields.io/badge/website-hotio.dev-ffb64c?style=flat-square)](https://hotio.dev/containers/unpackerr)

## Starting the container

Just the basics to get the container running:

```shell hl_lines="3 4 5 6 7 8"
docker run --rm \
    --name unpackerr \
    -e PUID=1000 \
    -e PGID=1000 \
    -e UMASK=002 \
    -e TZ="Etc/UTC" \
    -e ARGS="" \
    -e DEBUG="no" \
    -e UN_SONARR_0_URL="http://sonarr:8989" \
    -e UN_SONARR_0_API_KEY="<yourapikey>" \
    -e UN_RADARR_0_URL="http://radarr:7878" \
    -e UN_RADARR_0_API_KEY="<yourapikey>" \
    -e UN_LIDARR_0_URL="http://lidarr:8686" \
    -e UN_LIDARR_0_API_KEY="<yourapikey>" \
    -v /<host_folder_config>:/config \
    -v /<host_folder_downloads>:/downloads \
    hotio/unpackerr
```

The [highlighted](https://hotio.dev/containers/unpackerr) variables are all optional, the values you see are the defaults.

## Tags

| Tag                | Upstream                      |
| -------------------|-------------------------------|
| `release` (latest) | GitHub releases               |
| `testing`          | GitHub pre-releases           |
| `nightly`          | Every commit to master branch |

You can also find tags that reference a commit or version number.

## Configuration

You can use docker environment variables or a configuration file that should be stored in `/config/app/unpackerr.conf`. Don't forget to mount your volume where Unpackerr should look to find your downloads. You should use the same volume as is used in the Sonarr/Radarr/Lidarr containers. More advanced configuration methods are possible too, but take a look at the [upstream](https://github.com/davidnewhall/unpackerr) project page for more info on that.

## Executing your own scripts

If you have a need to do additional stuff when the container starts or stops, you can mount your script with `-v /docker/host/my-script.sh:/etc/cont-init.d/99-my-script` to execute your script on container start or `-v /docker/host/my-script.sh:/etc/cont-finish.d/99-my-script` to execute it when the container stops. An example script can be seen below.

```shell
#!/usr/bin/with-contenv bash

echo "Hello, this is me, your script."
```

## Troubleshooting a problem

By default all output is redirected to `/dev/null`, so you won't see anything from the application when using `docker logs`. Most applications write everything to a log file too. If you do want to see this output with `docker logs`, you can use `-e DEBUG="yes"` to enable this.
