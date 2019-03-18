#!/usr/bin/env bash

BASEDIR=$(dirname "$0")
source $BASEDIR/git.functions.sh
source $BASEDIR/nvm.functions.sh
source $BASEDIR/osx.functions.sh

function renamer () {
  rename -f $1 --remove-extension --append=$2
}

# Download YouTube Audio
function youtube-dl-audio () {
  youtube-dl \
    --download-archive downloaded.txt \
    --no-overwrites \
    -ict \
    --yes-playlist \
    --extract-audio \
    --audio-format mp3 \
    --audio-quality 0 \
    --socket-timeout 5 \
    $1
}

# Open current directory in GitKraken
function kraken () {
  open -na 'GitKraken' --args -p $(pwd)
}

function brew-daily() {
  brew upgrade

  echo "Cleaning up Homebrew..."
  brew cleanup

  echo "Sending Homebrew to the doctor..."
  brew doctor

  echo "Upgrade NPM stuff..."
  npm i -g
}

function ts-init () {
  informer "Installing typescript dependencies"
  npm i typescript tslint ts-node @types/node -D

  informer "Initiating TSLint"
  $(npm bin)/tslint --init

  informer "Initialising Typescript Configuration"
  $(npm bin)/tsc --init
}

# Destroy all the docker things and create that which u've destroyed!
function docker-rebuild () {
  informer "🗑 Destroying all the Docker things...."
  docker-compose down --rmi all --remove-orphans -v

  informer "🏗 Rebuidling all the Docker things...."
  docker-compose up --build
}
