# This is from FindFreeImage.cmake, part of nvidia-texture-tools project

#
# Try to find the FreeImage library and include path.
# Once done this will define
#
# FREEIMAGE_FOUND
# FREEIMAGE_INCLUDE_PATH
# FREEIMAGE_LIBRARY
#

set(FREEIMAGE_FOUND true  )
set(FREEIMAGE_INCLUDE_PATH
    "D:/win10/FreeImage3180Win32Win64/FreeImage/Dist/x64"
     "D:/win10/aspDep14/freeimageInstallVs2015x64"
    )
set(FREEIMAGE_LIBRARY
#    "D:/win10/FreeImage3180Win32Win64/FreeImage/Dist/x64/FreeImage.lib"
    "D:/win10/aspDep14/freeimageInstallVs2015x64/FreeImage.lib"
    )

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


IF (FREEIMAGE_INCLUDE_PATH AND FREEIMAGE_LIBRARY)
    INCLUDE_DIRECTORIES(${FREEIMAGE_INCLUDE_PATH})

    add_executable( Ch8ImageFilter2DFreeImageRGBA ImageFilter2D.cpp ImageFilter2D.cl)
    target_link_libraries( Ch8ImageFilter2DFreeImageRGBA ${OPENCL_LIBRARIES} ${FREEIMAGE_LIBRARIES} )
    
    configure_file(ImageFilter2D.cl ${CMAKE_CURRENT_BINARY_DIR}/ImageFilter2D.cl COPYONLY)
ENDIF  (FREEIMAGE_INCLUDE_PATH AND FREEIMAGE_LIBRARY)

configure_file(${CMAKE_SOURCE_DIR}/images/23.jfif  ${CMAKE_CURRENT_BINARY_DIR}/23.jfif COPYONLY)
