FROM debian:buster
ENTRYPOINT ["/entrypoint.sh"]
LABEL "com.github.actions.name"="GitHub Pages Deployment"
LABEL "com.github.actions.description"="Deploys static pages to GitHub Pages"
LABEL "com.github.actions.icon"="book-open"
LABEL "com.github.actions.color"="gray-dark"
LABEL "repository"="https://github.com/malept/github-action-gh-pages"
LABEL "maintainer"="Mark Lee <https://github.com/malept>"
