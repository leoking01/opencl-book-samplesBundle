add_executable( histogram histogram.cpp histogram_image.cl)
target_link_libraries( histogram ${OPENCL_LIBRARIES} )

configure_file(histogram_image.cl ${CMAKE_CURRENT_BINARY_DIR}/histogram_image.cl COPYONLY)
