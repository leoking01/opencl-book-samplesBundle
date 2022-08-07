
// Gaussian filter of image

__kernel void gaussian_filter(
        __read_only image2d_t srcImg,
        __write_only image2d_t dstImg,
      sampler_t sampler,
     int width, int height
        )
{
    // Gaussian Kernel is:
    // 1  2  1
    // 2  4  2
    // 1  2  1
    float kernelWeights[9] = { 1.0f, 2.0f, 1.0f,
                               2.0f, 4.0f, 2.0f,
                               1.0f, 2.0f, 1.0f };
    int2 startImageCoord = (int2) (get_global_id(0) - 1, get_global_id(1) - 1);
    int2 endImageCoord   = (int2) (get_global_id(0) + 1, get_global_id(1) + 1);
    int2 outImageCoord   = (int2) (get_global_id(0)    , get_global_id(1) );
    if (outImageCoord.x < width && outImageCoord.y < height)
    {
        int weight = 0;



        float4 outColor = (float4)(0.0f, 0.0f, 0.0f, 1.0f);
//         float3 outColor = (float3)(0.0f, 0.0f, 0.0f );
        for( int y = startImageCoord.y; y <= endImageCoord.y; y++)
        {
            for( int x = startImageCoord.x; x <= endImageCoord.x; x++)
            {
                float4 readClr  = (float4)read_imagef(srcImg, sampler, (int2)(x, y)  );
//                  printf("read_imagef = %f,%fl,",readClr.w,readClr.x  );
//printf("readClr = %fl,%fl,%fl,%fl,\n",readClr.w,readClr.x ,readClr.y,readClr.z );


//                outColor += (  read_imagef(srcImg, sampler, (int2)(x, y)  ) * (float1)(kernelWeights[weight] / 16.0f)  );
                outColor += ( readClr *  (kernelWeights[weight] / 16.0f)  );
//                 printf("outColor = %fl,%fl,%fl,%fl,\n",outColor.w,outColor.x ,outColor.y,outColor.z );
                weight += 1;
            }
        }

        outColor = (float4)(1.0f, 1.0f,1.0f, 1.0f);
outColor = outColor*255;

//  printf("outColor = %fl,%fl,%fl,%fl,\n",outColor.w,outColor.x ,outColor.y,outColor.z );
// printf("outColor,outImageCoord.x,y= %d,%d = %fl,%fl,%fl,%fl,\n",outImageCoord.x,outImageCoord.y,outColor.w,outColor.x ,outColor.y,outColor.z );
        // Write the output value to image
        write_imagef(dstImg, outImageCoord, outColor);
    }
}
