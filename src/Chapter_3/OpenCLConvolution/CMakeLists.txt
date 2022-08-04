add_executable( OpenCLConvolutionChap3 Convolution.cpp Convolution.cl)
target_link_libraries( OpenCLConvolutionChap3 ${OPENCL_LIBRARIES} )
