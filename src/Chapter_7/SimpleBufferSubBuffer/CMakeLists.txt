add_executable( SimpleBufferSubBuffer simple.cpp simple.cl)
target_link_libraries( SimpleBufferSubBuffer ${OPENCL_LIBRARIES} )

configure_file(simple.cl ${CMAKE_CURRENT_BINARY_DIR}/simple.cl COPYONLY)
