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

log
```
[1639036158.968197] info     | TermiosAgentLinux.cpp | init                     | running...             | fd: 3
[1639036158.968892] info     | Root.cpp           | set_verbose_level        | logger setup           | verbose_level: 4
[1639036159.005203] info     | Root.cpp           | create_client            | create                 | client_key: 0x1C10CBEE, session_id: 0x81
[1639036159.005439] info     | SessionManager.hpp | establish_session        | session established    | client_key: 0x1C10CBEE, address: 0
[1639036159.044356] info     | ProxyClient.cpp    | create_participant       | participant created    | client_key: 0x1C10CBEE, participant_id: 0x000(1)
[1639036159.045065] info     | ProxyClient.cpp    | create_topic             | topic created          | client_key: 0x1C10CBEE, topic_id: 0x000(2), participant_id: 0x000(1)
[1639036159.045672] info     | ProxyClient.cpp    | create_publisher         | publisher created      | client_key: 0x1C10CBEE, publisher_id: 0x000(3), participant_id: 0x000(1)
[1639036159.048888] info     | ProxyClient.cpp    | create_datawriter        | datawriter created     | client_key: 0x1C10CBEE, datawriter_id: 0x000(5), publisher_id: 0x000(3)
```

ros2 topic echo /std_msgs_msg_Int32
data: 38
---
data: 39
---
data: 40
---
data: 41
---

