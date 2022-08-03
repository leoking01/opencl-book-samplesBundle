add_executable( sinewave sinewave.cpp sinewave.cl)

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


#find_package( OpenGL REQUIRED )

#GLEW
#find_package( GLEW  REQUIRED ) # D:\win10\aspDep14\glew-2.1.0\install\lib\cmake\glew
#D:\win10\aspDep14\glew-2.1.0\install\lib\cmake\glew
find_package( glew  REQUIRED "D:/win10/aspDep14/glew-2.1.0/install" )
include_directories(  ${glew_INCLUDE_DIR}  "D:/win10/aspDep14/glew-2.1.0/install/include" )


target_link_libraries( sinewave
    ${OPENCL_LIBRARIES}
    ${GLUT_LIBRARIES} ${OPENGL_LIBRARIES}  -lGLEW
    "D:/win10/aspDep14/glew-2.1.0/install/lib/libglew32d.lib"
     "D:/win10/aspDep14/FreeGLUT/install/lib/freeglut_staticd.lib"
    )

configure_file(sinewave.cl ${CMAKE_CURRENT_BINARY_DIR}/sinewave.cl COPYONLY   ) #
