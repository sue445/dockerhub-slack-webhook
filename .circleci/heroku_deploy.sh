#!/bin/bash -xe

heroku config:add BUNDLE_WITHOUT="test:development" --app $HEROKU_APP_NAME

# FIXME
# + git push git@heroku.com:chatwork-mention-task.git ccf21e57d60a3beabab465be4769844860455c39:refs/heads/master
# fatal: Could not read from remote repository.
#
# Please make sure you have the correct access rights
# and the repository exists.
# Exited with code 128
. ./.circleci/retty.sh

retry 5 git push git@heroku.com:$HEROKU_APP_NAME.git $CIRCLE_SHA1:refs/heads/master
