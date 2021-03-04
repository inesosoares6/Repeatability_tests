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
    error_z = htcvive->pose.position.z + opti->pose.position.z;
    error = sqrt(pow(error_x,2) + pow(error_y,2) + pow(error_z,2));

    myfile << error_x << "," << error_y << "," << error_z << "," << error << "\n";
    ROS_INFO("\n\nError x: [%f] \nError y: [%f] \nError z: [%f]\n\nError: [%f]\n", error_x, error_y, error_z, error);
}

int main(int argc, char **argv)
{
  ros::init(argc, argv, "sync_HTC_OT");

  ros::NodeHandle nh;

  message_filters::Subscriber<PoseStamped> htcvive_sub(nh, "HTCposition", 1);
  message_filters::Subscriber<PoseStamped> optiTrack_sub(nh, "vrpn_client_node/IndexFinger/pose", 1);

  typedef sync_policies::ApproximateTime<PoseStamped, PoseStamped> MySyncPolicy;

  myfile.open("HTC_OT_data");
  myfile << "Tracking errors between HTC Vive and OptiTrack\n";
  myfile << "Error x, Error y, Error z, Error\n";

  Synchronizer<MySyncPolicy> sync(MySyncPolicy(100),htcvive_sub, optiTrack_sub);
  sync.registerCallback(boost::bind(&callback, _1, _2));

  ros::spin();

  myfile.close();

  return 0;
}