# docker-dind
Docker in docker image allowing to set up daemon configuration via environment variables

Available variables:

- `DOCKER_REGISTRY_MIRROR` => `--registry-mirror`
- `DOCKER_INSECURE_REGISTRY` => `--insecure-registry`
- `DOCKER_MAX_CONCURRENT_DOWNLOADS` => `--max-concurrent-downloads`
