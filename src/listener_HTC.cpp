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

 void callback(const geometry_msgs::PoseStamped::ConstPtr& htcvive, const geometry_msgs::PoseStamped::ConstPtr& opti)
{
    float error;
    float dist_htcvive, dist_optiTrack;
    dist_htcvive = sqrt(pow(htcvive->pose.position.x,2)+pow(htcvive->pose.position.y,2)+pow(htcvive->pose.position.z,2));
    dist_optiTrack = sqrt(pow(opti->pose.position.x,2)+pow(opti->pose.position.y,2)+pow(opti->pose.position.z,2));
    error = dist_htcvive-dist_optiTrack;

    ROS_INFO("Error: [%f]", error);
}

int main(int argc, char **argv)
{
  ros::init(argc, argv, "listener_HTC");

  ros::NodeHandle nh;

  message_filters::Subscriber<PoseStamped> htcvive_sub(nh, "HTCposition", 1);
  message_filters::Subscriber<PoseStamped> optiTrack_sub(nh, "vrpn_client_node/IndexFinger/pose", 1);

  typedef sync_policies::ApproximateTime<PoseStamped, PoseStamped> MySyncPolicy;

  Synchronizer<MySyncPolicy> sync(MySyncPolicy(1000), htcvive_sub, optiTrack_sub);
  sync.registerCallback(boost::bind(&callback, _1, _2));

  ros::spin();

  return 0;
}