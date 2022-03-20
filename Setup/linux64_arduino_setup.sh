#!/bin/bash -e

# Reference sites
# Jetsonhacks : https://www.jetsonhacks.com/2019/10/04/install-arduino-ide-on-jetson-dev-kit/


########################################################
## Run shell without sudo!! Or you cannot launch icon ##
########################################################

INSTALL_DIR=${HOME}
# Direct Jetson support starts at 1.8.10
ARDUINO_VERSION=1.8.13

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}==== Prepare Packages with apt ====${NC}"
sudo apt update
sudo apt install -y git curl wget libfontconfig libxft2 xz-utils rsync

echo -e "${GREEN}==== Installing arduino IDE ====${NC}"
cd ~/Downloads
if [ -d ./arduino-$ARDUINO_VERSION-linux64.tar.xz ]
then
	echo -e "${RED} delete exist folder ${NC}"
	rm -rf arduino-*
fi

wget https://downloads.arduino.cc/arduino-$ARDUINO_VERSION-linux64.tar.xz
tar -xvf arduino-$ARDUINO_VERSION-linux64.tar.xz
rm -rf arduino-$ARDUINO_VERSION-linux64.tar.xz

echo -e "${GREEN}==== Move Arduino Foler into INSTALL_DIR ====${NC}"
mv ~/Downloads/arduino-$ARDUINO_VERSION $INSTALL_DIR
sudo usermod -a -G dialout $(whoami)

cd $INSTALL_DIR/arduino-$ARDUINO_VERSION
sudo ./install.sh
./arduino-linux-setup.sh $USER

echo -e "${GREEN}==== Installing TeensyduinoInstall ====${NC}"
cd ~/Downloads
if [ -d ./TeensyduinoInstall.linux64 ]
then
	echo -e "${RED} delete exist file ${NC}"
	rm -rf TeensyduinoInstall.linux64
fi

wget https://www.pjrc.com/teensy/td_153/TeensyduinoInstall.linux64
chmod 755 TeensyduinoInstall.linux64
./TeensyduinoInstall.linux64 --dir=$INSTALL_DIR/arduino-$ARDUINO_VERSION

echo -e "${GREEN}==== Udev rules setup ====${NC}"
if [ ! -e /etc/udev/rules.d/00-teensy.rules ]; then
    wget https://www.pjrc.com/teensy/00-teensy.rules
    sudo cp 00-teensy.rules /etc/udev/rules.d/
fi

