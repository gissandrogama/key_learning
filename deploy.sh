#!/bin/sh
echo "starting deploy process"
git remote add gigalixir https://gissandrogama%40gmail.com:9f363480-5637-4110-8fcd-6ff653eab615@git.gigalixir.com/key-learning.git
BRANCH=$(if [ "$TRAVIS_PULL_REQUEST" == "false" ]; then echo $TRAVIS_BRANCH; else echo $TRAVIS_PULL_REQUEST_BRANCH; fi)
echo "TRAVIS_BRANCH=$TRAVIS_BRANCH, PR=$PR"
echo "------------------------------------"
echo "BRANCH=$BRANCH"
if [ "$BRANCH" == "main" ]; then
  echo "Pushing HEAD to master branch on Gigalixir."
  git push gigalixir HEAD:master
  echo "Deploy completed."
fi
echo "Exiting.
