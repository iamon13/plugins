#!/bin/sh -xu

# print system information
uname -a

# use JDK 11  build for Debian Buster / Ubuntu 18.10 or higher, and JDK 8 build otherwise
if apt-cache show openjfx --no-all-versions | grep "Version: 8"; then
	REPO="deb [arch=all] https://get.filebot.net/deb/ universal-jdk8 main"
else
	REPO="deb [arch=all] https://get.filebot.net/deb/ universal main"
fi

echo "Use Repository: $REPO"

# 0. Install pre-requisites
sudo apt-get install --install-recommends -y dirmngr gnupg-curl apt-transport-https

# 1. Import signing keys
sudo apt-key adv --fetch-keys "https://raw.githubusercontent.com/filebot/plugins/master/gpg/maintainer.pub"

# 2. Add deb repository to sources.list
echo "$REPO" | sudo tee /etc/apt/sources.list.d/filebot.list

# 3. Update package index
sudo apt-get update

# 4. Install FileBot and its dependencies
sudo apt-get install --install-recommends -y filebot

# 5. Test Run
filebot -script fn:sysinfo
