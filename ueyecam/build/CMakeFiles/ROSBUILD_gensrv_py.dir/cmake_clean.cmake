FILE(REMOVE_RECURSE
  "../src/ueyecam/srv"
  "../srv_gen"
  "../srv_gen"
  "CMakeFiles/ROSBUILD_gensrv_py"
  "../src/ueyecam/srv/__init__.py"
  "../src/ueyecam/srv/_setFPS.py"
  "../src/ueyecam/srv/_setROIFull.py"
  "../src/ueyecam/srv/_setROI.py"
  "../src/ueyecam/srv/_setEdgeEnhancement.py"
  "../src/ueyecam/srv/_CaptureFrame.py"
  "../src/ueyecam/srv/_setShutterAuto.py"
  "../src/ueyecam/srv/_setFPSAuto.py"
  "../src/ueyecam/srv/_SaveImage.py"
  "../src/ueyecam/srv/_setGainAuto.py"
  "../src/ueyecam/srv/_setEncoding.py"
)

# Per-language clean rules from dependency scanning.
FOREACH(lang)
  INCLUDE(CMakeFiles/ROSBUILD_gensrv_py.dir/cmake_clean_${lang}.cmake OPTIONAL)
ENDFOREACH(lang)
