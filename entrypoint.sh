#!/bin/bash

set -xeo pipefail
cd /arquivo
echo "\n\n\n#########\nimporting\n-------------"
if [ ! -z ${INPUT_INPUT_FOLDER} ]; then
  input_path="${GITHUB_WORKSPACE}/${INPUT_INPUT_FOLDER}"
else
  input_path=$GITHUB_WORKSPACE
fi

STATIC_PLS=true NOTEBOOK_PATH=$input_path bundle exec rails static:import

# we boot up the server in the bg
STATIC_PLS=true bundle exec rails s -d

echo "\n\n\n#########\nbuilding\n-------------"

# so we can fetch the static html
STATIC_PLS=true bundle exec rails static:generate
cd /arquivo/out

echo "\n\n\n#########\npublishing\n-------------"

if [ ! -z ${INPUT_CNAME} ]; then
  echo ${INPUT_CNAME} > CNAME
fi


remote_repo="https://${INPUT_GITHUB_ACTOR}:${INPUT_GITHUB_TOKEN}@github.com/${INPUT_GITHUB_REPOSITORY}.git" && \
remote_branch=${INPUT_REMOTE_BRANCH}

cd $GITHUB_WORKSPACE

git remote add pages-remote $remote_repo

if ! git ls-remote --exit-code --heads pages-remote "$remote_branch" > /dev/null;
then
  git checkout -b $remote_branch
  git push -u pages-remote $remote_branch
else
  git checkout -b $remote_branch pages-remote/$remote_branch
  git pull pages-remote $remote_branch
fi

mv .git /tmp/gitfolder && rm -rf * && cp -r /arquivo/out/. . && mv /tmp/gitfolder .git

git config user.name "${INPUT_GITHUB_ACTOR}"
git config user.email "${INPUT_GITHUB_ACTOR}@users.noreply.github.com"
git add -A

echo -n 'Files to Commit:'
ls -l | wc -l

git commit -m 'mawl build.' > /dev/null 2>&1
git push
