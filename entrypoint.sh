#!/bin/sh

set +e
set +x

if test -z "$DOCS_PATH"; then
    DOCS_PATH=docs
fi

if test -z "$PUBLISH_BRANCH"; then
    PUBLISH_BRANCH=gh-pages
fi

echo "DOCS_PATH: $DOCS_PATH"
echo "PUBLISH_BRANCH: $PUBLISH_BRANCH"

if git branch --list | grep -q $PUBLISH_BRANCH; then
    echo 'branch already exists, deleting first'
    git branch -D $PUBLISH_BRANCH
fi

git checkout --orphan $PUBLISH_BRANCH
cp -R $DOCS_PATH /github/docs
git rm -r -f .
rm -r .
mv /github/docs/* .

if test -n $SHOW_UNDERSCORE_FILES; then
    touch .nojekyll
fi

echo "machine github.com login $GITHUB_ACTOR password $GITHUB_TOKEN" > ~/.netrc
chmod 600 ~/.netrc

git add .
git config user.name "$GITHUB_ACTOR"
git config user.email "$GITHUB_ACTOR@users.noreply.github.com"
git commit $GIT_COMMIT_FLAGS -m "Publish"
git push -f origin $PUBLISH_BRANCH
