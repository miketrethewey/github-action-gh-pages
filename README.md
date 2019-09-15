# GitHub Action: Deploy GitHub Pages

A simple GitHub Action to deploy already generated static pages to GitHub Pages.

## Input parameters

* `docsPath` - defaults to `docs`
* `gitCommitEmail` (required) - the email to use when committing to the repository. Per the docs,
  it must be a verified email for the pages to be published.
* `gitCommitFlags`: Any extra `git commit` flags to pass, such as `--no-verify`.
* `gitCommitUser`: The value to set `git config user.name`, defaults to the repository owner.
* `publishBranch` - defaults to `gh-pages`
* `showUnderscoreFiles` - if set, adds a `.nojekyll` file to the root so files that start with
  `_` are accessible.
