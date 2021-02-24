#include "ros/ros.h"
#include "std_msgs/String.h"
#include "geometry_msgs/Vector3.h"
#include "geometry_msgs/PoseStamped.h"

void hololensCallback(const geometry_msgs::Vector3::ConstPtr& pose)
{
  ROS_INFO("HoloLens2 x: [%f]", pose->x);
  ROS_INFO("HoloLens2 y: [%f]", pose->y);
  ROS_INFO("HoloLens2 z: [%f]", pose->z);
}

void optiTrackCallback(const geometry_msgs::PoseStamped::ConstPtr& opti)
{
  ROS_INFO("OptiTrack x: [%f]", opti->pose.position.x);
  ROS_INFO("OptiTrack y: [%f]", opti->pose.position.y);
  ROS_INFO("OptiTrack z: [%f]", opti->pose.position.z);
}

int main(int argc, char **argv)
{
  ros::init(argc, argv, "listener");

  ros::NodeHandle n;

  ros::Subscriber sub_HL2 = n.subscribe("handTracking", 1000, hololensCallback);
  ros::Subscriber sub_Opti = n.subscribe("vrpn_client_node/Structure2/pose", 1000, optiTrackCallback);

  ros::spin();

  return 0;
}
