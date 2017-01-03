#!/bin/sh
set -e

# no arguments passed
# or first arg is `-f` or `--some-option`
if [ "$#" -eq 0 -o "${1#-}" != "$1" ]; then
	# add our default arguments
	set -- dockerd \
		--host=unix:///var/run/docker.sock \
		--host=tcp://0.0.0.0:2375 \
		--storage-driver=vfs \
		"$@"
fi

if [ "$DOCKER_REGISTRY_MIRROR" ]; then
  set -- "$@" --registry-mirror=$DOCKER_REGISTRY_MIRROR
fi

if [ "$DOCKER_INSECURE_REGISTRY" ]; then
  set -- "$@" --insecure-registry=$DOCKER_INSECURE_REGISTRY
fi

if [ "$DOCKER_MAX_CONCURRENT_DOWNLOADS" ]; then
  if [ $1 == "dockerd" ]; then
    shift
  fi
  set -- "$@" --max-concurrent-downloads=$DOCKER_MAX_CONCURRENT_DOWNLOADS
fi

if [ "$1" = 'dockerd' ]; then
	# if we're running Docker, let's pipe through dind
	# (and we'll run dind explicitly with "sh" since its shebang is /bin/bash)
	set -- sh "$(which dind)" "$@"
fi

exec "$@"
