#!/bin/bash

set -xeo pipefail

# where is our markdown stored?
if [ ! -z ${INPUT_INPUT_FOLDER} ]; then
  input_path="${GITHUB_WORKSPACE}/${INPUT_INPUT_FOLDER}"
else
  input_path=$GITHUB_WORKSPACE
fi

# where are we pushing the generated html to?
# TODO: this can probably be replaced with checkout@v3,
# which persists a PAT in the git config?
remote_repo="https://${INPUT_GITHUB_ACTOR}:${INPUT_GITHUB_TOKEN}@github.com/${INPUT_GITHUB_REPOSITORY}.git" && \
remote_branch=${INPUT_REMOTE_BRANCH}


echo -n "\n\n\n#########\nimporting\n-------------"

cd /arquivo
STATIC_PLS=true NOTEBOOK_PATH="$input_path" bundle exec rails static:import

# we boot up the server in the bg
STATIC_PLS=true bundle exec rails s -d

echo -n "\n\n\n#########\nbuilding\n-------------"

STATIC_PLS=true bundle exec rails static:generate

if [ ! -z ${INPUT_CNAME} ]; then
  echo ${INPUT_CNAME} > /arquivo/out/CNAME
fi

# our html has been generated! let's push this out.
echo -n "\n\n\n#########\npublishing\n-------------"

cd $GITHUB_WORKSPACE

# TODO: again, probably not necessary to add a remote?
git remote add pages-remote $remote_repo
git fetch pages-remote

# if the remote branch does not exist, create it
# else, check it out & fetch latest contents
if ! git ls-remote --exit-code --heads pages-remote "$remote_branch";
then
  git checkout -b $remote_branch
  git push -u pages-remote $remote_branch
else
  git checkout -b $remote_branch pages-remote/$remote_branch
  git pull pages-remote $remote_branch
fi

# sometimes files might be deleted. preserving the .git folder,
# we just delete everything & copy over the generated html
mv .git /tmp/gitfolder && rm -rf * && cp -r /arquivo/out/. . && mv /tmp/gitfolder .git

git config user.name "${INPUT_GITHUB_ACTOR}"
git config user.email "${INPUT_GITHUB_ACTOR}@users.noreply.github.com"
git add -A

echo -n 'Files to Commit: '
ls -l | wc -l

git commit -m 'mawl build.' > /dev/null 2>&1
git push
