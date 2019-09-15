#!/bin/sh

set +e
set +x

if test -z "$INPUT_DOCSPATH"; then
    INPUT_DOCSPATH=docs
fi

if test -z "$INPUT_PUBLISHBRANCH"; then
    INPUT_PUBLISHBRANCH=gh-pages
fi

if test -z "$INPUT_GITCOMMITEMAIL"; then
    echo 'Please set the gitCommitEmail input variable to a GitHub verified email address.' 1>&2
    exit 1
fi

if test -z "$INPUT_GITCOMMITUSER"; then
    INPUT_GITCOMMITUSER="$GITHUB_ACTOR"
fi

if git branch --list | grep -q $INPUT_PUBLISHBRANCH; then
    git branch -D $INPUT_PUBLISHBRANCH
fi

git checkout --orphan $INPUT_PUBLISHBRANCH
mv $INPUT_DOCSPATH /github/docs
git rm -r -f .
rm -r *
ls -d .* | grep -vP '^\.(\.?|git)$' | xargs rm -r
mv /github/docs/* .

if test -n $INPUT_SHOWUNDERSCOREFILES; then
    touch .nojekyll
fi

echo "machine github.com login $GITHUB_ACTOR password $GITHUB_TOKEN" > ~/.netrc
echo "machine api.github.com login $GITHUB_ACTOR password $GITHUB_TOKEN" >> ~/.netrc
chmod 600 ~/.netrc

git add .
git config user.name "$GITHUB_ACTOR"
git config user.email "$INPUT_GITCOMMITEMAIL"
git commit $INPUT_GITCOMMITFLAGS -m "Publish"
git push -f $INPUT_GITPUSHFLAGS origin $INPUT_PUBLISHBRANCH
curl --verbose --netrc --request POST \
    --header 'Accept: application/vnd.github.mister-fantastic-preview+json' \
    https://api.github.com/repos/$GITHUB_REPOSITORY/pages/builds

