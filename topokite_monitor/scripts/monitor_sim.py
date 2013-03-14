#!/usr/bin/env python
import roslib; roslib.load_manifest('topokite_monitor')
import rospy
import math
import psutil
from std_msgs.msg import String
from sensor_msgs.msg import Joy
from asctec_hl_comm.msg import *
from topokite_monitor.msg import *

data_slow = mav_monitor_slow()
data_slow.latitude = rospy.get_param('~init_latitude', 46.523)
data_slow.longitude = rospy.get_param('~init_longitude', 6.569)
data_slow.altitude = rospy.get_param('~init_altitude', 400)

data_fast = mav_monitor_fast()

def joyCallback(data_):
    data_fast.header = data_.header
    data_fast.control_axes = [int(2048*(1+x)) for x in data_.axes]
    data_fast.control_buttons = data_.buttons

def rcCallback(data_):
    data_fast.channel = data_.channel

def statusCallback(data_):
    global data
    data_slow.header = data_.header
    data_slow.battery_voltage = data_.battery_voltage
    data_slow.flight_mode_ll = data_.flight_mode_ll
    data_slow.flight_time = data_.flight_time
    data_slow.cpu_load = data_.cpu_load
    data_slow.gps_status = data_.gps_status
    data_slow.gps_num_satellites = data_.gps_num_satellites

def gpsCallback(data_):
    data_slow.latitude = data_.latitude
    data_slow.longitude = data_.longitude
    data_slow.altitude = data_.altitude
    data_slow.pressure_height = data_.pressure_height
    data_slow.velocity_x = data_.velocity_x
    data_slow.velocity_y = data_.velocity_y

def monitor():
    global data_fast
    global data_slow
    pub_fast = rospy.Publisher('topokite/monitor_fast', mav_monitor_fast)
    pub_slow = rospy.Publisher('topokite/monitor_slow', mav_monitor_slow)
    
    rospy.init_node('monitor')
    rospy.Subscriber('joy', Joy, joyCallback)
    while not rospy.is_shutdown():
        for x in range(0, 10):
            pub_fast.publish(data_fast)
            rospy.sleep(0.1)
        time = rospy.get_time()
        data_slow.battery_voltage = 11.0 + math.sin(time/30.0)
        data_slow.cpu_load = psutil.cpu_percent(interval=0)
        pub_slow.publish(data_slow)

if __name__ == '__main__':
    try:
        monitor()
    except rospy.ROSInterruptException:
        pass