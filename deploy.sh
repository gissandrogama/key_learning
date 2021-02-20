#!/bin/sh
echo "starting deploy process"
git remote add gigalixir https://gissandrogama%40gmail.com:aaeef65e-974f-4a0e-9c1f-087ce5cfc3e2@git.gigalixir.com/key-learning.git
BRANCH=$(if [ "$TRAVIS_PULL_REQUEST" == "false" ]; then echo $TRAVIS_BRANCH; else echo $TRAVIS_PULL_REQUEST_BRANCH; fi)
echo "TRAVIS_BRANCH=$TRAVIS_BRANCH, PR=$PR"
echo "------------------------------------"
echo "BRANCH=$BRANCH"
if [ "$BRANCH" == "main" ]; then
  echo "Pushing HEAD to master branch on Gigalixir."
  git push gigalixir main
  echo "Deploy completed."
fi
echo "Exiting.
