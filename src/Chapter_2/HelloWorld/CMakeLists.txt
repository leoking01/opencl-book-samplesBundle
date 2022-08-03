add_executable( HelloWorld HelloWorld.cpp HelloWorld.cl)
target_link_libraries( HelloWorld ${OPENCL_LIBRARIES} )

configure_file(HelloWorld.cl ${CMAKE_CURRENT_BINARY_DIR}/HelloWorld.cl COPYONLY)
