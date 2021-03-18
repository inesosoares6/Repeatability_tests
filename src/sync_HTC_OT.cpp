#include "ros/ros.h"
#include "std_msgs/String.h"
#include "geometry_msgs/Vector3.h"
#include "geometry_msgs/PoseStamped.h"
#include <message_filters/subscriber.h>
#include <message_filters/synchronizer.h>
#include <message_filters/sync_policies/approximate_time.h>
#include <iostream>
#include <fstream>

using namespace message_filters;
using namespace geometry_msgs;

std::ofstream myfile;

 void callback(const geometry_msgs::PoseStamped::ConstPtr& htcvive, const geometry_msgs::PoseStamped::ConstPtr& opti)
{
    float error_x, error_y, error_z, error;
    error_x = htcvive->pose.position.x - opti->pose.position.x;
    error_y = htcvive->pose.position.y - opti->pose.position.y;
    error_z = htcvive->pose.position.z - opti->pose.position.z;
    error = sqrt(pow(error_x,2) + pow(error_y,2) + pow(error_z,2));

    myfile << htcvive->header.stamp.sec << "," << htcvive->header.stamp.nsec << ","  
      << htcvive->pose.position.x << "," << htcvive->pose.position.y << "," << htcvive->pose.position.z << "," 
      << opti->pose.position.x << "," << opti->pose.position.y << "," << opti->pose.position.z << "," << error << "\n";
    ROS_INFO("Error: [%f]", error);
}

int main(int argc, char **argv)
{
  ros::init(argc, argv, "sync_HTC_OT");

  ros::NodeHandle nh_param("~");
  ros::NodeHandle nh;

  std::string testNumber;
  std::string conditions;
  nh_param.getParam("testNumber", testNumber);
  ROS_INFO("Test Number : %s", testNumber.c_str());

  message_filters::Subscriber<PoseStamped> htcvive_sub(nh, "HTCposition", 1);
  message_filters::Subscriber<PoseStamped> optiTrack_sub(nh, "vrpn_client_node/IndexFinger/pose", 1);

  typedef sync_policies::ApproximateTime<PoseStamped, PoseStamped> MySyncPolicy;

  std::string fileName;
  std::string nameDevice;
  nameDevice = "HTC_OT_data";
  fileName = nameDevice + testNumber.c_str();
  myfile.open(fileName);
  myfile << "sec, nsec, HTC_x, HTC_y, HTC_z, OT_x, OT_y, OT_z, Error\n";

  Synchronizer<MySyncPolicy> sync(MySyncPolicy(1000),htcvive_sub, optiTrack_sub);
  sync.registerCallback(boost::bind(&callback, _1, _2));

  ros::spin();

  myfile.close();

  return 0;
}