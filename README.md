# GitHub Action: Deploy GitHub Pages

A simple GitHub Action to deploy already generated static pages to GitHub Pages.

## Environment variables

* `DOCS_PATH` - defaults to `docs`
* `GIT_COMMIT_FLAGS` - any extra `git commit` flags to pass, such as `--no-verify`.
* `PUBLISH_BRANCH` - defaults to `gh-pages`
* `SHOW_UNDERSCORE_FILES` - if set, adds a `.nojekyll` file to the root so files that start with
  `_` are accessible.
