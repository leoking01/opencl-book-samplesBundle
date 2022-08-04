# NV GLUT paths
SET( CMAKE_INCLUDE_PATH $ENV{NVSDKCOMPUTE_ROOT}/shared/inc )
SET( CMAKE_LIBRARY_PATH $ENV{NVSDKCOMPUTE_ROOT}/shared/lib )
FIND_PACKAGE(DirectX)
add_definitions(-DUNICODE -D_UNICODE)
link_directories(${CMAKE_LIBRARY_PATH})


include_directories( "C:/Program\ Files\ (x86)/Microsoft\ DirectX\ SDK\ \(June 2010\)/Include"  )


IF (D3DX10_LIBRARY AND D3DX10_LIBRARY)
        add_executable( D3Dinterop D3Dinterop.cpp D3Dinterop.cl)
	include_directories( ${DX10_INCLUDE_PATH})

        link_directories("C:/Program\ Files\ \(x86\)/Microsoft\ DirectX\ SDK\ \(June 2010\)/Lib/x64" )
        set(D3DX10_LIBRARY  "C:/Program\ Files\ \(x86\)/Microsoft\ DirectX\ SDK\ \(June 2010\)/Lib/x64/d3dx10.lib"  )
        message( WARNING  "{D3DX10_LIBRARY} = ${D3DX10_LIBRARY}"  )



	target_link_libraries( D3Dinterop ${OPENCL_LIBRARIES} ${D3D10_LIBRARY} ${D3DX10_LIBRARY})
	configure_file(D3Dinterop.cl ${CMAKE_CURRENT_BINARY_DIR}/D3Dinterop.cl COPYONLY)
	configure_file(D3Dinterop.fx ${CMAKE_CURRENT_BINARY_DIR}/D3Dinterop.fx COPYONLY)
ENDIF (D3DX10_LIBRARY AND D3DX10_LIBRARY)
