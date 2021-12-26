#!/bin/bash -e

# Reference sites
# Jetsonhacks : https://www.jetsonhacks.com/2019/10/04/install-arduino-ide-on-jetson-dev-kit/

INSTALL_DIR=${HOME}
# Direct Jetson support starts at 1.8.10
ARDUINO_VERSION=1.8.13

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}==== Patch Teensyduino ====${NC}"
cd $INSTALL_DIR/arduino-$ARDUINO_VERSION/hardware/teensy/avr
curl https://raw.githubusercontent.com/micro-ROS/micro_ros_arduino/foxy/extras/patching_boards/platform_teensy.txt > platform.txt

echo -e "${GREEN}==== Use the pre-compiled micro_ros_arduino library ====${NC}"
cd ~/Arduino/libraries/
wget https://github.com/micro-ROS/micro_ros_arduino/archive/refs/tags/v2.0.2-foxy.tar.gz
tar -xvf v2.0.2-foxy.tar.gz
rm -rf v2.0.2-foxy.tar.gz

echo -e "${GREEN}==== Docker Setup for micro-ros agent ====${NC}"
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

echo -e "${GREEN}==== ROS 2 Foxy Docker Image Pull ====${NC}"
docker pull tge1375/micro-ros-jetson-demo:foxy


