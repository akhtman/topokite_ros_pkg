#!/usr/bin/env python
import roslib; roslib.load_manifest('topokite_monitor')
import rospy
from std_msgs.msg import String
from asctec_hl_comm.msg import *
from topokite_monitor.msg import *

data_slow = mav_monitor_slow()
data_fast = mav_monitor_fast()

def statusCallback(data_):
    global data_slow
    data_slow.header = data_.header
    data_slow.battery_voltage = data_.battery_voltage
    data_slow.flight_mode_ll = data_.flight_mode_ll
    data_slow.serial_interface_enabled = data_.serial_interface_enabled
    data_slow.flight_time = data_.flight_time
    data_slow.cpu_load = data_.cpu_load
    data_slow.gps_status = data_.gps_status
    data_slow.gps_num_satellites = data_.gps_num_satellites

def rcCallback(data_):
    global data_fast
    data_fast.rc_channel = data_.channel

def gpsCallback(data_):
    global data_slow
    data_slow.latitude = data_.latitude
    data_slow.longitude = data_.longitude
    data_slow.altitude = data_.altitude
    data_slow.pressure_height = data_.pressure_height
    data_slow.velocity_x = data_.velocity_x
    data_slow.velocity_y = data_.velocity_y
    
def monitor():
    global data_slow
    global data_fast
    pub_slow = rospy.Publisher('topokite/monitor_slow', mav_monitor_slow)
    pub_fast = rospy.Publisher('topokite/monitor_fast', mav_monitor_fast)
    rospy.init_node('monitor')
    rospy.Subscriber('fcu/status', mav_status, statusCallback)
    rospy.Subscriber('fcu/rcdata', mav_rcdata, rcCallback)
    rospy.Subscriber('fcu/gps_custom', GpsCustom, gpsCallback)
    while not rospy.is_shutdown():
        for x in range(0, 10):
            pub_fast.publish(data_fast)
            rospy.sleep(0.1)
        pub_slow.publish(data_slow)

if __name__ == '__main__':
    try:
        monitor()
    except rospy.ROSInterruptException:
        pass