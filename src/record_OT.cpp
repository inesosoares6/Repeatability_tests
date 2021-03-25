#include "ros/ros.h"
#include "std_msgs/String.h"
#include "geometry_msgs/Vector3.h"
#include "geometry_msgs/PoseStamped.h"
#include <iostream>
#include <fstream>

using namespace geometry_msgs;

std::ofstream myfile;

void optiTrackCallback(const geometry_msgs::PoseStamped::ConstPtr& opti)
{
  ROS_INFO("Recording");
    myfile << opti->header.stamp.sec << "," << opti->header.stamp.nsec << ","  
      << opti->pose.position.x << "," << opti->pose.position.y << "," << opti->pose.position.z << "\n";
}

int main(int argc, char **argv)
{
  ros::init(argc, argv, "listener");

  ros::NodeHandle n_OT;

  ros::Subscriber sub_Opti = n_OT.subscribe("vrpn_client_node/IndexFinger/pose", 1000, optiTrackCallback);

  myfile.open("OptiTrack_data");
  myfile << "seconds,nanoseconds,OT_x,OT_y,OT_z\n";

  ros::spin();

  myfile.close();

  return 0;
}