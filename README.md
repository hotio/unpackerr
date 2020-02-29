# unpackerr

<img src="https://raw.githubusercontent.com/hotio/unraid-templates/master/hotio/img/unpackerr.png" alt="Logo" height="130" width="130">

[![GitHub](https://img.shields.io/badge/source-github-lightgrey)](https://github.com/hotio/docker-unpackerr)
[![Docker Pulls](https://img.shields.io/docker/pulls/hotio/unpackerr)](https://hub.docker.com/r/hotio/unpackerr)
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

| Tag         | Description                    | Build Status                                                                                                                                                     | Last Updated                                                                                                                                                                  |
| ------------|--------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| latest      | The same as `stable`           |                                                                                                                                                                  |                                                                                                                                                                               |
| stable      | Stable version                 | [![Build Status](https://cloud.drone.io/api/badges/hotio/docker-unpackerr/status.svg?ref=refs/heads/stable)](https://cloud.drone.io/hotio/docker-unpackerr)      | [![GitHub last commit (branch)](https://img.shields.io/github/last-commit/hotio/docker-unpackerr/stable)](https://github.com/hotio/docker-unpackerr/commits/stable)           |
| semi-stable | Stable version, pre-releases   | [![Build Status](https://cloud.drone.io/api/badges/hotio/docker-unpackerr/status.svg?ref=refs/heads/semi-stable)](https://cloud.drone.io/hotio/docker-unpackerr) | [![GitHub last commit (branch)](https://img.shields.io/github/last-commit/hotio/docker-unpackerr/semi-stable)](https://github.com/hotio/docker-unpackerr/commits/semi-stable) |
| unstable    | Unstable version, every commit | [![Build Status](https://cloud.drone.io/api/badges/hotio/docker-unpackerr/status.svg?ref=refs/heads/unstable)](https://cloud.drone.io/hotio/docker-unpackerr)    | [![GitHub last commit (branch)](https://img.shields.io/github/last-commit/hotio/docker-unpackerr/unstable)](https://github.com/hotio/docker-unpackerr/commits/unstable)       |

You can also find tags that reference a commit or version number.

## Configuration

You can use a configuration file that should be stored in `/config/app/unpackerr.conf` or/and use the docker environment variables. Take a look at the upstream project page for more info. Also don't forget to mount your volumes where Unpackerr should look to find your downloads.

```shell
-e UN_SONARR_0_URL="http://sonarr:8989"
-e UN_SONARR_0_API_KEY="<yourapikey>"
-e UN_SONARR_0_PATH="/downloads"
-e UN_RADARR_0_URL="http://radarr:7878"
-e UN_RADARR_0_API_KEY="<yourapikey>"
-e UN_RADARR_0_PATH="/downloads"
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
