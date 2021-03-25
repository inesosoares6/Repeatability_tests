#include "ros/ros.h"
#include "std_msgs/String.h"
#include "geometry_msgs/Vector3.h"
#include "geometry_msgs/PoseStamped.h"
#include <iostream>
#include <fstream>

using namespace geometry_msgs;

std::ofstream myfile;

void htcViveCallback(const geometry_msgs::PoseStamped::ConstPtr& htcVive)
{
    ROS_INFO("Recording");
    myfile << htcVive->header.stamp.sec << "," << htcVive->header.stamp.nsec << ","  
      << htcVive->pose.position.x << "," << htcVive->pose.position.y << "," << htcVive->pose.position.z << "\n";
}

int main(int argc, char **argv)
{
  ros::init(argc, argv, "listener");

  ros::NodeHandle n_HTC;

  ros::Subscriber sub_HTC = n_HTC.subscribe("HTCposition", 1000, htcViveCallback);

  myfile.open("HTC_data");
  myfile << "seconds,nanoseconds,HTC_x,HTC_y,HTC_z\n";

  ros::spin();

  myfile.close();

  return 0;
}