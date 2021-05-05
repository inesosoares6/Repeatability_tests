# Accuracy and Repeatability Tests

**Devices**: Microsoft HoloLens 2, HTC Vive and OptiTrack

## ROS terminals
- Open bridge to HoloLens 2 communication:

    *roslaunch rosbridge_server rosbridge_websocket.launch*

- Launch VRPN

    *roslaunch vrpn_client_ros sample.launch*

- Read topic info

    *rostopic echo /HLposition*
    *rostopic echo /HTCposition*
    *rostopic echo /vrpn_client_node/IndexFinger/pose*

- Record bags

    *rosbag record -O <file_name> /HLposition /vrpn_client_node/IndexFinger/pose*
    *rosbag record -O <file_name> /HTCposition /vrpn_client_node/IndexFinger/pose*

- Run scripts

    *rosrun repeatability_tests sync_HL_OT _testNumber:=_#*
    *rosrun repeatability_tests sync_HTC_OT _testNumber:=_#*
