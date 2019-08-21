# GitHub Action: Deploy GitHub Pages

A simple GitHub Action to deploy already generated static pages to GitHub Pages.

## Environment variables

* `DOCS_PATH` - defaults to `docs`
* `GIT_COMMIT_EMAIL` (required) - the email to use when committing to the repository. Per the docs,
  it must be a verified email for the pages to be published.
* `GIT_COMMIT_USER` - `git config user.name`, defaults to the repository owner.
* `GIT_COMMIT_FLAGS` - any extra `git commit` flags to pass, such as `--no-verify`.
* `PUBLISH_BRANCH` - defaults to `gh-pages`
* `SHOW_UNDERSCORE_FILES` - if set, adds a `.nojekyll` file to the root so files that start with
  `_` are accessible.
