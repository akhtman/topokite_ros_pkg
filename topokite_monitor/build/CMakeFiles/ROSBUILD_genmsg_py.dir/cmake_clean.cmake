FILE(REMOVE_RECURSE
  "../msg_gen"
  "../src/topokite_monitor/msg"
  "CMakeFiles/ROSBUILD_genmsg_py"
  "../src/topokite_monitor/msg/__init__.py"
  "../src/topokite_monitor/msg/_mav_monitor.py"
  "../src/topokite_monitor/msg/_mav_monitor_slow.py"
  "../src/topokite_monitor/msg/_mav_monitor_fast.py"
)

# Per-language clean rules from dependency scanning.
FOREACH(lang)
  INCLUDE(CMakeFiles/ROSBUILD_genmsg_py.dir/cmake_clean_${lang}.cmake OPTIONAL)
ENDFOREACH(lang)
