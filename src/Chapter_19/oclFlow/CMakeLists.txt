# NV GLUT paths
SET( CMAKE_INCLUDE_PATH $ENV{NVSDKCOMPUTE_ROOT}/shared/inc )

IF("${ISWIN64}" STREQUAL "Win64") 
	SET( CMAKE_LIBRARY_PATH "$ENV{NVSDKCOMPUTE_ROOT}/shared/lib/x64;$ENV{NVSDKCOMPUTE_ROOT}/OpenCL/common/x64" )
ELSE("${ISWIN64}" STREQUAL "Win64") 
	SET( CMAKE_LIBRARY_PATH "$ENV{NVSDKCOMPUTE_ROOT}/shared/lib/Win32;$ENV{NVSDKCOMPUTE_ROOT}/OpenCL/common/Win32" )
ENDIF("${ISWIN64}" STREQUAL "Win64") 

#FIND_PACKAGE(GLUT REQUIRED)
#FIND_PACKAGE(OpenGL REQUIRED)
FIND_PACKAGE(OpenCV REQUIRED)
FIND_PACKAGE(GLEW REQUIRED)


if( 0 )
    # GLUT
    find_package(GLUT REQUIRED)
    include_directories(${GLUT_INCLUDE_DIR})
    if(NOT GLUT_FOUND)
        message(ERROR "GLUT not found!")
    endif(NOT GLUT_FOUND)
endif( )

# freeglut
set(freeglut_DIR "D:/win10/aspDep14/FreeGLUT/install/lib/cmake/FreeGLUT" )
find_package(freeglut REQUIRED PATHS "D:/win10/aspDep14/FreeGLUT/install") #D:\win10\aspDep14\FreeGLUT\install\lib\cmake\FreeGLUT
include_directories(${freeglut_INCLUDE_DIR}  "C:/ProgramData/NVIDIA\ Corporation/CUDA\ Samples/v8.0/common/inc"   )


message(WARNING  "GLUT_INCLUDE_DIR= ${GLUT_INCLUDE_DIR}")
message(WARNING  "GLUT_DIR= ${GLUT_DIR}")


# OpenGL
find_package(OpenGL REQUIRED)
include_directories(${OpenGL_INCLUDE_DIRS})
link_directories(${OpenGL_LIBRARY_DIRS})
add_definitions(${OpenGL_DEFINITIONS})
if(NOT OPENGL_FOUND)
    message(ERROR "OPENGL not found!")
endif(NOT OPENGL_FOUND)


#GLEW
#find_package( GLEW  REQUIRED ) # D:\win10\aspDep14\glew-2.1.0\install\lib\cmake\glew
#D:\win10\aspDep14\glew-2.1.0\install\lib\cmake\glew
find_package( glew  REQUIRED "D:/win10/aspDep14/glew-2.1.0/install" )
include_directories(  ${glew_INCLUDE_DIR}  "D:/win10/aspDep14/glew-2.1.0/install/include" )



# Detect 32/64 bit build environment and set glut  and glew libs correctly
IF(WIN32)
	STRING(REGEX MATCH "Win64" ISWIN64 ${CMAKE_GENERATOR})
	IF("${ISWIN64}" STREQUAL "Win64") 
		SET( GLUT_LIBRARIES "freeglut.lib glew64.lib")
		FIND_PATH( GLEW_LIBRARY_PATH glew64.lib PATHS $ENV{NVSDKCOMPUTE_ROOT}/shared/lib/x64)
	ELSE("${ISWIN64}" STREQUAL "Win64") 
		SET( GLUT_LIBRARIES "freeglut.lib glew32.lib")
		FIND_PATH( GLEW_LIBRARY_PATH glew32.lib PATHS $ENV{NVSDKCOMPUTE_ROOT}/shared/lib/Win32 )
	ENDIF("${ISWIN64}" STREQUAL "Win64") 
ENDIF(WIN32)

# find glew include
FIND_PATH( GLEW_INCLUDE_PATH GL/glew.h PATHS $ENV{NVSDKCOMPUTE_ROOT}/shared/inc )
FIND_PATH( OCLUTILS_INCLUDE_PATH oclUtils.h PATHS $ENV{NVSDKCOMPUTE_ROOT}/OpenCL/common/inc )
FIND_PATH( SHRUTILS_INCLUDE_PATH shrUtils.h PATHS $ENV{NVSDKCOMPUTE_ROOT}/shared/inc )
IF(WIN32)
    FIND_LIBRARY( OCLUTILS_LIBRARIES oclUtils32.lib PATHS $ENV{NVSDKCOMPUTE_ROOT}/OpenCL/common/lib/Win32 )
ELSE(WIN32)
    #todo : this needs to be arch specific 32/64 on Linux
    FIND_LIBRARY( OCLUTILS_LIBRARIES liboclUtil_x86_64.a PATHS $ENV{NVSDKCOMPUTE_ROOT}/OpenCL/common/lib/ )
    FIND_LIBRARY( SHRUTILS_LIBRARIES libshrutil_x86_64.a PATHS $ENV{NVSDKCOMPUTE_ROOT}/shared/lib/ )
ENDIF(WIN32)


MESSAGE("${GLEW_INCLUDE_PATH}")

#We statically link because OpenCV does this by default so to link there we use the same
# comment this out if all other libraries use dynamic linking
if(MSVC)
foreach(flag_var CMAKE_CXX_FLAGS CMAKE_CXX_FLAGS_DEBUG CMAKE_CXX_FLAGS_RELEASE CMAKE_CXX_FLAGS_MINSIZEREL CMAKE_CXX_FLAGS_RELWITHDEBINFO)
    if(${flag_var} MATCHES "/MD")
        string(REGEX REPLACE "/MD" "/MT" ${flag_var} "${${flag_var}}")
    endif(${flag_var} MATCHES "/MD")
    if(${flag_var} MATCHES "/MDd")
        string(REGEX REPLACE "/MDd" "/MTd" ${flag_var} "${${flag_var}}")
    endif(${flag_var} MATCHES "/MDd")
endforeach(flag_var)
endif(MSVC)

# copy the .cl kernel files and the data files
configure_file(filters.cl ${CMAKE_CURRENT_BINARY_DIR}/filters.cl COPYONLY)
configure_file(motion.cl ${CMAKE_CURRENT_BINARY_DIR}/motion.cl COPYONLY)
configure_file(lkflow.cl ${CMAKE_CURRENT_BINARY_DIR}/lkflow.cl COPYONLY)
configure_file(data/minicooper/frame10.pgm ${CMAKE_CURRENT_BINARY_DIR}/data/minicooper/frame10.pgm COPYONLY)
configure_file(data/minicooper/frame11.pgm ${CMAKE_CURRENT_BINARY_DIR}/data/minicooper/frame11.pgm COPYONLY)
configure_file(readme.txt ${CMAKE_CURRENT_BINARY_DIR}/readme.txt COPYONLY)


# todo: Linux opencv ubuntu distro req's cudart at compile time, add library "cudart" and path to toolkit below to compile on Linux

link_directories(${CMAKE_LIBRARY_PATH} )
add_executable( oclFlow oclFlow.cpp flowGL.cpp)
include_directories( ${GLUT_INCLUDE_DIR} ${OPENGL_INCLUDE_DIR} ${OCLUTILS_INCLUDE_PATH} ${SHRUTILS_INCLUDE_PATH} )
target_link_libraries( oclFlow
    ${OPENCL_LIBRARIES}
    ${GLUT_LIBRARIES}
    ${OpenCV_LIBS}
    ${OCLUTILS_LIBRARIES} ${SHRUTILS_LIBRARIES}
    ${GLEW_LIBRARY}



    ${OPENCL_LIBRARIES}
    ${GLUT_LIBRARIES} ${OPENGL_LIBRARIES}  -lGLEW
    "D:/win10/aspDep14/glew-2.1.0/install/lib/libglew32d.lib"
     "D:/win10/aspDep14/FreeGLUT/install/lib/freeglut_staticd.lib"

    )
