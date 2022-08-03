# This is an example project to show and test the usage of the FindOpenCL
# script.

cmake_minimum_required( VERSION 2.6 )
project( CL_Book )

set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

#export CFLAGS=-m32
#set(CFLAGS "${CFLAGS} -m32 "  )
set(CFLAGS "${CFLAGS} -m64 "  )


find_package( OpenCL REQUIRED )

set(OPENCL_LIBRARIES  "C:/Program\ Files/NVIDIA\ GPU\ Computing\ Toolkit/CUDA/v8.0/lib/x64/OpenCL.lib"  )
message( WARNING  "{OPENCL_LIBRARIES} = ${OPENCL_LIBRARIES}"  )

include_directories( ${OPENCL_INCLUDE_DIRS} )
include_directories( "${CMAKE_SOURCE_DIR}/khronos" )

link_directories( "C:/Program\ Files/NVIDIA\ GPU\ Computing\ Toolkit/CUDA/v8.0/include" )
link_directories( "C:/Program\ Files/NVIDIA\ GPU\ Computing\ Toolkit/CUDA/v8.0/lib/x64" )

SUBDIRS(src)

