# unpackerr

![logo](https://hotio.dev/img/unpackerr.png)

![Base](https://img.shields.io/badge/base-alpine-blue)
[![GitHub](https://img.shields.io/badge/source-github-lightgrey)](https://github.com/hotio/docker-unpackerr)
[![Docker Pulls](https://img.shields.io/docker/pulls/hotio/unpackerr)](https://hub.docker.com/r/hotio/unpackerr)
[![GitHub Registry](https://img.shields.io/badge/registry-ghcr.io-blue)](https://github.com/users/hotio/packages/container/package/unpackerr)
[![Discord](https://img.shields.io/discord/610068305893523457?color=738ad6&label=discord&logo=discord&logoColor=white)](https://discord.gg/3SnkuKp)
[![Upstream](https://img.shields.io/badge/upstream-project-yellow)](https://github.com/davidnewhall/unpackerr)

## Starting the container

Just the basics to get the container running:

```shell
docker run --rm --name unpackerr -v /<host_folder_config>:/config hotio/unpackerr
```

The environment variables below are all optional, the values you see are the defaults.

```shell
-e PUID=1000
-e PGID=1000
-e UMASK=002
-e TZ="Etc/UTC"
-e ARGS=""
-e DEBUG="no"
```

## Tags

| Tag                | Upstream                      |
| -------------------|-------------------------------|
| `release` (latest) | GitHub releases               |
| `testing`          | GitHub pre-releases           |
| `nightly`          | Every commit to master branch |

You can also find tags that reference a commit or version number.

## Configuration

You can use docker environment variables or a configuration file that should be stored in `/config/app/unpackerr.conf`. Don't forget to mount your volume where Unpackerr should look to find your downloads. You should use the same volume as is used in the Sonarr/Radarr/Lidarr containers. More advanced configuration methods are possible too, but take a look at the [upstream](https://github.com/davidnewhall/unpackerr) project page for more info on that.

```shell
-v /<host_folder_downloads>:/downloads
-e UN_SONARR_0_URL="http://sonarr:8989"
-e UN_SONARR_0_API_KEY="<yourapikey>"
-e UN_RADARR_0_URL="http://radarr:7878"
-e UN_RADARR_0_API_KEY="<yourapikey>"
-e UN_LIDARR_0_URL="http://lidarr:8686"
-e UN_LIDARR_0_API_KEY="<yourapikey>"
```

## Executing your own scripts

If you have a need to do additional stuff when the container starts or stops, you can mount your script with `-v /docker/host/my-script.sh:/etc/cont-init.d/99-my-script` to execute your script on container start or `-v /docker/host/my-script.sh:/etc/cont-finish.d/99-my-script` to execute it when the container stops. An example script can be seen below.

```shell
#!/usr/bin/with-contenv bash

echo "Hello, this is me, your script."
```

## Troubleshooting a problem

By default all output is redirected to `/dev/null`, so you won't see anything from the application when using `docker logs`. Most applications write everything to a log file too. If you do want to see this output with `docker logs`, you can use `-e DEBUG="yes"` to enable this.
