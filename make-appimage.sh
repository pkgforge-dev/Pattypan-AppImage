#!/bin/sh

set -eu

ARCH=$(uname -m)
export ARCH
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=https://github.com/yarl/pattypan/blob/master/src/pattypan/resources/logo.png
#export JAVA_HOME="/usr/lib/jvm/java-26-openjdk"
#export PATH="${JAVA_HOME}/bin:${PATH}"

# Deploy dependencies
quick-sharun \
	./AppDir/bin/* \
	/usr/lib/jvm/java-26-openjdk/bin \
    /usr/lib/jvm/java-26-openjdk/conf \
    /usr/lib/jvm/java-26-openjdk/legal \
    /usr/lib/jvm/java-26-openjdk/lib

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage

# Test the app for 12 seconds, if the test fails due to the app
# having issues running in the CI use --simple-test instead
quick-sharun --simple-test ./dist/*.AppImage
