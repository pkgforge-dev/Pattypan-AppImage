#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm jre-openjdk

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

# Comment this out if you need an AUR package
make-aur-package java-openjfx

# If the application needs to be manually built that has to be done down here
mkdir -p ./AppDir/bin
cd ./AppDir/bin
latest_jar=$(wget --retry-connrefused --tries=30 \
	https://api.github.com/repos/yarl/pattypan/releases -O - \
	| sed 's/[()",{} ]/\n/g' | grep -o -m 1 "https.*/pattypan-java-.*.jar"
)
wget  --retry-connrefused --tries=30 "$latest_jar"
echo '#!/bin/sh
exec java -jar "$APPDIR"/bin/pattypan-java-26-02.jar "$@"' > ./pattypan
chmod +x ./*
echo "$latest_jar" | awk -F'/' '{print $(NF-1)}' > ~/version 
