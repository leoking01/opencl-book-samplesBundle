add_executable( sinewave sinewave.cpp )


# GLUT
find_package(GLUT REQUIRED)
include_directories(${GLUT_INCLUDE_DIR})
if(NOT GLUT_FOUND)
    message(ERROR "GLUT not found!")
endif(NOT GLUT_FOUND)

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


find_package( OpenGL REQUIRED )
find_package( GLEW  REQUIRED )



target_link_libraries( sinewave ${OPENCL_LIBRARIES}     ${GLUT_LIBRARIES} ${OPENGL_LIBRARIES}  -lGLEW )

configure_file(sinewave.cl ${CMAKE_CURRENT_BINARY_DIR}/sinewave.cl COPYONLY   ) #
