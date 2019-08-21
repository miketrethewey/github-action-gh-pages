#!/bin/sh

set +e
set +x

if test -z "$DOCS_PATH"; then
    DOCS_PATH=docs
fi

if test -z "$PUBLISH_BRANCH"; then
    PUBLISH_BRANCH=gh-pages
fi

if test -z "$GIT_COMMIT_EMAIL"; then
    echo 'Please set the GIT_COMMIT_EMAIL environment variable to a GitHub verified email address.' 1>&2
    exit 1
fi

if test -z "$GIT_COMMIT_USER"; then
    GIT_COMMIT_USER="$GITHUB_ACTOR"
fi

if git branch --list | grep -q $PUBLISH_BRANCH; then
    git branch -D $PUBLISH_BRANCH
fi

git checkout --orphan $PUBLISH_BRANCH
mv $DOCS_PATH /github/docs
git rm -r -f .
rm -r *
ls -d .* | grep -vP '^\.(\.?|git)$' | xargs rm -r
mv /github/docs/* .

if test -n $SHOW_UNDERSCORE_FILES; then
    touch .nojekyll
fi

echo "machine github.com login $GITHUB_ACTOR password $GITHUB_TOKEN" > ~/.netrc
chmod 600 ~/.netrc

git add .
git config user.name "$GITHUB_ACTOR"
git config user.email "$GIT_COMMIT_EMAIL"
git commit $GIT_COMMIT_FLAGS -m "Publish"
git push -f origin $PUBLISH_BRANCH
