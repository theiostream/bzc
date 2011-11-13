#!/bin/sh

sudo easy_install requests

git clone git://github.com/theiostream/bzc.git
sudo cp ./bzc/bzc /usr/bin

rm -rf ./bzc
