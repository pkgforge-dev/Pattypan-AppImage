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
#make-aur-package PACKAGENAME

# If the application needs to be manually built that has to be done down here
mkdir -p ./AppDir/bin
cd ./AppDir/bin
wget https://github.com/yarl/pattypan/releases/download/v26.02/pattypan-java-26-02.jar
echo '#!/bin/sh
exec java -jar "$APPDIR"/bin/pattypan-java-26-02.jar "$@"' > ./pattypan
chmod +x ./*
