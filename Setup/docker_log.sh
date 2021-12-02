# Source the ROS 2 installation
source /opt/ros/foxy/install/setup.bash

# Create a workspace and download the micro-ROS tools
cd ~/
mkdir -p microros_ws && cd microros_ws
git clone -b $ROS_DISTRO https://github.com/micro-ROS/micro_ros_setup.git src/micro_ros_setup

# Update dependencies using rosdep
sudo apt update && rosdep update
rosdep install --from-path src --ignore-src -y

# Install pip
sudo apt-get install python3-pip

# Build micro-ROS tools and source them
colcon build
source install/local_setup.bash

# After agent Build
docker run -it --name micro-ros-foxy --net=host -v /dev:/dev --privileged tge1375/micro-ros-jetson-demo:foxy
cd ~/microros_ws
source /opt/ros/foxy/install/setup.bash
source install/setup.bash 

ros2 run micro_ros_agent micro_ros_agent serial --dev /dev/ttyACM0
# Insert USB

ros2 topic echo /micro_ros_arduino_node_publisher

