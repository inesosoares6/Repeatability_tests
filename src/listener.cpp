#include "ros/ros.h"
#include "std_msgs/String.h"
#include "geometry_msgs/Vector3.h"
#include "geometry_msgs/PoseStamped.h"
#include <iostream>
#include <fstream>

using namespace geometry_msgs;

std::ofstream myfile;

void hololensCallback(const geometry_msgs::PoseStamped::ConstPtr& hololens)
{
    ROS_INFO("Timestamp: [%f].[%f]", hololens->header.stamp.sec, hololens->header.stamp.nsec);
    myfile << hololens->header.stamp.sec << "," << hololens->header.stamp.nsec << ","  
      << hololens->pose.position.x << "," << hololens->pose.position.y << "," << hololens->pose.position.z << "\n";
}
/*
void optiTrackCallback(const geometry_msgs::PoseStamped::ConstPtr& opti)
{
  ROS_INFO("OptiTrack x: [%f]", opti->pose.position.x);
  ROS_INFO("OptiTrack y: [%f]", opti->pose.position.y);
  ROS_INFO("OptiTrack z: [%f]", opti->pose.position.z);
}
*/
int main(int argc, char **argv)
{
  ros::init(argc, argv, "listener");

  ros::NodeHandle n;

  ros::Subscriber sub_HL2 = n.subscribe("HLposition", 1000, hololensCallback);
  //ros::Subscriber sub_Opti = n.subscribe("vrpn_client_node/Structure2/pose", 1000, optiTrackCallback);

  myfile.open("HoloLens2_data");
  myfile << "seconds, nanoseconds, HL_x, HL_y, HL_z\n";

  ros::spin();

  myfile.close();

  return 0;
}