FILE(REMOVE_RECURSE
  "../src/ueyecam/srv"
  "../srv_gen"
  "../srv_gen"
  "CMakeFiles/ROSBUILD_gensrv_cpp"
  "../srv_gen/cpp/include/ueyecam/setFPS.h"
  "../srv_gen/cpp/include/ueyecam/setROIFull.h"
  "../srv_gen/cpp/include/ueyecam/setROI.h"
  "../srv_gen/cpp/include/ueyecam/setEdgeEnhancement.h"
  "../srv_gen/cpp/include/ueyecam/CaptureFrame.h"
  "../srv_gen/cpp/include/ueyecam/setShutterAuto.h"
  "../srv_gen/cpp/include/ueyecam/setFPSAuto.h"
  "../srv_gen/cpp/include/ueyecam/SaveImage.h"
  "../srv_gen/cpp/include/ueyecam/setGainAuto.h"
  "../srv_gen/cpp/include/ueyecam/setEncoding.h"
)

# Per-language clean rules from dependency scanning.
FOREACH(lang)
  INCLUDE(CMakeFiles/ROSBUILD_gensrv_cpp.dir/cmake_clean_${lang}.cmake OPTIONAL)
ENDFOREACH(lang)
