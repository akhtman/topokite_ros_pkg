Header header

#MAV status

float32     battery_voltage
string      flight_mode_ll
string      state_estimation
string      position_control
bool        serial_interface_enabled
bool        serial_interface_active
float32     flight_time
float32     cpu_load

string      motor_status

string      gps_status
int32       gps_num_satellites

bool        have_SSDK_parameters

float32     timesync_offset

#RC data

uint16[8]   rc_channel

#Control data

uint16[6]   control_axes
int32[]     control_buttons

#GPS data

float64     latitude
float64     longitude
float64     altitude
float64     pressure_height
float64     velocity_x
float64     velocity_y