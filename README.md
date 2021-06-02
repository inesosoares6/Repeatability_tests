# Accuracy and Repeatability Tests

**Devices**: Microsoft HoloLens 2, HTC Vive and OptiTrack

## ROS terminals
- Open bridge to HoloLens 2 communication:

      roslaunch rosbridge_server rosbridge_websocket.launch

- Launch VRPN

      roslaunch vrpn_client_ros sample.launch

- Read topic info

      rostopic echo /HLposition
      rostopic echo /HTCposition
      rostopic echo /vrpn_client_node/IndexFinger/pose

- Record bags

      rosbag record -O <file_name> /HLposition /vrpn_client_node/IndexFinger/pose
      rosbag record -O <file_name> /HTCposition /vrpn_client_node/IndexFinger/pose

- Run scripts

      rosrun repeatability_tests sync_HL_OT _testNumber:=_#
      rosrun repeatability_tests sync_HTC_OT _testNumber:=_#

## Data analysis - MATLAB
- *SamePositionTests* -> script to analyse the tests without motion
- *VelocityTests* -> script to analyse the tests with motion
- *RotateControllerTest* -> script to analyse the Test #3 where the HTC vive controller rotated 360º
- *FrequencyAnalysis* -> scripts to analyse the sample frequency
- *calculateDelay* -> function to calculate the delay in the motion tests
- *calculateVelocity* -> function to calculate the velocity
- *interpolate* -> function to interpolate points and resulting in vecotrs with the same size
- *joinReadData* -> function to read the csv files and save it to arrays for motion tests
- *plotGraphs* -> function to plot the graphs for motion tests
- *plotGraphsSimple* -> function to plot the graphs for the tests without motion
- *readData* -> function to read the csv files and save it to arrays
- *save2csv* -> function to save the interpolated & synchronized data to a csv file

## ROS scripts purposes
- *sync_HL_OT* -> synchronizes the data between HoloLens 2 and OptiTrack, prints it to a file and shows the error in the terminal
- *sync_HTC_OT* -> synchronizes the data between HTC Vive and OptiTrack, prints it to a file and shows the error in the terminal
- *record_HL* -> records the HoloLens 2 data (timestamp and position) to a csv file
- *record_HTC* -> records the HTC Vive data (timestamp and position) to a csv file
- *record_OT* -> records the OptiTrack data (timestamp and position) to a csv file
- *listener_HL* -> calculates the error between HoloLens 2 and OptiTrack data and prints in the terminal
- *listener_HTC* -> calculates the error between HTC Vive and OptiTrack data and prints in the terminal

## Author
Inês de Oliveira Soares (ines.o.soares@inesctec.pt | up201606615@up.pt)
- Master Student - Electrical and Computer Engineering @ FEUP
- Master Thesis Development @ INESC TEC
