SUBDIRS(
    Chapter_2/HelloWorld
	Chapter_3/OpenCLInfo 
	Chapter_3/OpenCLConvolution 
	Chapter_6/HelloBinaryWorld 
	Chapter_7/SimpleBufferSubBuffer
	Chapter_8/ImageFilter2D 
        Chapter_8/ImageFilter2Dcv
	Chapter_12/VectorAdd
	Chapter_14/histogram 
	Chapter_16/Dijkstra

#        Chapter_19/oclFlow  ##  nvidia only. some old.  need libshrutil_x86_64.a
        # 这个库在工程 AAAAA_GPU-Computing-SDK-4.2.9MkUbun 中可以找到。

        Chapter_22/
        )

IF(WIN32 OR UNIX AND NOT APPLE)
	# Sinewave uses wgl or glx
#        SUBDIRS(Chapter_12/Sinewave)  # 暂时不用看。  用的是旧的api.  换的api较多。
ENDIF(WIN32 OR UNIX AND NOT APPLE)

IF(WIN32)
	# D3Dinterop is Windows only
        SUBDIRS(Chapter_11/D3Dinterop)
ENDIF(WIN32)
