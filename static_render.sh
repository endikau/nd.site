#!/usr/bin/env bash
set -e

git submodule update --init --recursive

rm -rf _hugo/static/assets
mkdir -p _hugo/static/assets
cp -R _submodules/nd.assets/dist* _hugo/static/assets

cd _hugo
hugo --minify --cleanDestinationDir
