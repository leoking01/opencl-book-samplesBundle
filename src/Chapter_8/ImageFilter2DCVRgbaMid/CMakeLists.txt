# This is from FindFreeImage.cmake, part of nvidia-texture-tools project

#
# Try to find the FreeImage library and include path.
# Once done this will define
#
# FREEIMAGE_FOUND
# FREEIMAGE_INCLUDE_PATH
# FREEIMAGE_LIBRARY
#

if( 0 )
    set(FREEIMAGE_FOUND true  )
    set(FREEIMAGE_INCLUDE_PATH  "D:/win10/FreeImage3180Win32Win64/FreeImage/Dist/x64"  )
    set(FREEIMAGE_LIBRARY  "D:/win10/FreeImage3180Win32Win64/FreeImage/Dist/x64/FreeImage.lib"  )

    set(WIN32  true)
    IF (WIN32)
    message(STATUS   "--------------->   chapter8.  this is WIN32.")
    FIND_PATH( FREEIMAGE_INCLUDE_PATH FreeImage.h
        ${PROJECT_SOURCE_DIR}/extern/FreeImage
        DOC "The directory where FreeImage.h resides")
    FIND_LIBRARY( FREEIMAGE_LIBRARY
        NAMES FreeImage freeimage
        PATHS
        ${PROJECT_SOURCE_DIR}/FreeImage
        DOC "The FreeImage library")
    ELSE (WIN32)
    FIND_PATH( FREEIMAGE_INCLUDE_PATH FreeImage.h
        /usr/include
        /usr/local/include
        /sw/include
        /opt/local/include
        DOC "The directory where FreeImage.h resides")
    FIND_LIBRARY( FREEIMAGE_LIBRARY
        NAMES FreeImage freeimage
        PATHS
        /usr/lib64
        /usr/lib
        /usr/local/lib64
        /usr/local/lib
        /sw/lib
        /opt/local/lib
        DOC "The FreeImage library")
    ENDIF (WIN32)

    SET(FREEIMAGE_LIBRARIES ${FREEIMAGE_LIBRARY})

    IF (FREEIMAGE_INCLUDE_PATH AND FREEIMAGE_LIBRARY)
    SET( FREEIMAGE_FOUND TRUE CACHE BOOL "Set to TRUE if GLEW is found, FALSE otherwise")
    ELSE (FREEIMAGE_INCLUDE_PATH AND FREEIMAGE_LIBRARY)
    SET( FREEIMAGE_FOUND FALSE CACHE BOOL "Set to TRUE if GLEW is found, FALSE otherwise")
    ENDIF (FREEIMAGE_INCLUDE_PATH AND FREEIMAGE_LIBRARY)

    MARK_AS_ADVANCED(
        FREEIMAGE_FOUND
        FREEIMAGE_LIBRARY
        FREEIMAGE_LIBRARIES
        FREEIMAGE_INCLUDE_PATH)

endif ()

set( OpenCV_DIR  "D:/win10/Cv451GLVs2015install/x64/vc14/lib")
find_package(OpenCV  REQUIRED PATHS  "D:/win10/Cv451GLVs2015install"   )
include_directories( ${OpenCV_INCLUDE})
link_directories( ${OpenCV_LIBS_DIR}  ${OpenCV_DIR})

#IF (FREEIMAGE_INCLUDE_PATH AND FREEIMAGE_LIBRARY)
#INCLUDE_DIRECTORIES(${FREEIMAGE_INCLUDE_PATH})
add_executable( Ch8ImageFilter2DCVRgbaMid ImageFilter2Dcv.cpp ImageFilter2Dcv.cl)
target_link_libraries( Ch8ImageFilter2DCVRgbaMid ${OPENCL_LIBRARIES} ${FREEIMAGE_LIBRARIES}  ${OpenCV_LIBRARIES})
configure_file(ImageFilter2Dcv.cl ${CMAKE_CURRENT_BINARY_DIR}/ImageFilter2Dcv.cl COPYONLY)
#ENDIF  (FREEIMAGE_INCLUDE_PATH AND FREEIMAGE_LIBRARY)
#configure_file(${CMAKE_SOURCE_DIR}/images/e9.jpeg  ${CMAKE_CURRENT_BINARY_DIR}/e9.jpeg COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/images/23.jfif  ${CMAKE_CURRENT_BINARY_DIR}/23.jfif COPYONLY)
