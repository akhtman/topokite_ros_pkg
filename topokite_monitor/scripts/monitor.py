#!/usr/bin/env python
import roslib; roslib.load_manifest('topokite_monitor')
import rospy
from std_msgs.msg import String
from asctec_hl_comm.msg import *
from topokite_monitor.msg import *

data = mav_monitor()

def statusCallback(data_):
    global data
    data.header = data_.header
    data.battery_voltage = data_.battery_voltage
    data.flight_mode_ll = data_.flight_mode_ll
    data.flight_time = data_.flight_time
    data.cpu_load = data_.cpu_load
    data.gps_status = data_.gps_status
    data.gps_num_satellites = data_.gps_num_satellites

def rcCallback(data_):
    data.channel = data_.channel

def gpsCallback(data_):
    data.latitude = data_.latitude
    data.longitude = data_.longitude
    data.altitude = data_.altitude
    data.pressure_height = data_.pressure_height
    data.velocity_x = data_.velocity_x
    data.velocity_y = data_.velocity_y
    
def monitor():
    global data
    pub = rospy.Publisher('topokite/monitor', mav_monitor)
    rospy.init_node('monitor')
    rospy.Subscriber('fcu/status', mav_status, statusCallback)
    rospy.Subscriber('fcu/rcdata', mav_rcdata, rcCallback)
    rospy.Subscriber('fcu/gps_custom', GpsCustom, gpsCallback)
    while not rospy.is_shutdown():
        str = 'flight mode: %s' % data.flight_mode_ll
        rospy.loginfo(str)
        pub.publish(data)
        rospy.sleep(0.1)

if __name__ == '__main__':
    try:
        monitor()
    except rospy.ROSInterruptException:
        pass