FROM debian:buster
LABEL "repository"="https://github.com/malept/github-action-gh-pages"
LABEL "maintainer"="Mark Lee <https://github.com/malept>"

RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates curl git && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
