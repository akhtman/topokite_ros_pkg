FILE(REMOVE_RECURSE
  "../msg_gen"
  "../src/topokite_monitor/msg"
  "CMakeFiles/ROSBUILD_genmsg_cpp"
  "../msg_gen/cpp/include/topokite_monitor/mav_monitor.h"
  "../msg_gen/cpp/include/topokite_monitor/mav_monitor_slow.h"
  "../msg_gen/cpp/include/topokite_monitor/mav_monitor_fast.h"
)

# Per-language clean rules from dependency scanning.
FOREACH(lang)
  INCLUDE(CMakeFiles/ROSBUILD_genmsg_cpp.dir/cmake_clean_${lang}.cmake OPTIONAL)
ENDFOREACH(lang)
