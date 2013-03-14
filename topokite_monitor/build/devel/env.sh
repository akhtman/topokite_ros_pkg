#!/usr/bin/env sh
# generated from catkin/cmake/templates/env.sh.in

if [ $# -eq 0 ] ; then
  /bin/echo "Entering environment at '/home/topo/ros/topokite_ros_pkg/topokite_monitor/build/devel', type 'exit' to leave"
  . "/home/topo/ros/topokite_ros_pkg/topokite_monitor/build/devel/setup.sh"
  "$SHELL" -i
  /bin/echo "Exiting environment at '/home/topo/ros/topokite_ros_pkg/topokite_monitor/build/devel'"
else
  . "/home/topo/ros/topokite_ros_pkg/topokite_monitor/build/devel/setup.sh"
  exec "$@"
fi
