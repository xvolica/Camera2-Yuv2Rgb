# Camera2-Yuv2Rgb in NDK

Android5.0 Camera2 ImageReader 读取YUV格式转为RGB格式的方法

#高效：
在双Cortex-A72大核+四Cortex-A53小核（RK3399）下处理640x480图片平均耗时22ms

不同方法性能比较见http://www.mclover.cn

#使用方法：
1.将so库放到jniLibs文件夹下
2.将src中代码放入工程

#示例方法：
    public void onImageAvailable(ImageReader reader) {
        Image image = reader.acquireLatestImage();
        Image.Plane[] plane = image.getPlanes();
        byte[][] mYUVBytes = new byte[plane.length][];
        for (int i = 0; i < plane.length; ++i) {
            mYUVBytes[i] = new byte[plane[i].getBuffer().capacity()];
        }
        int[] mRGBBytes = new int[640 * 480];

        for (int i = 0; i < plane.length; ++i) {
            plane[i].getBuffer().get(mYUVBytes[i]);
        }

        final int yRowStride = plane[0].getRowStride();
        final int uvRowStride = plane[1].getRowStride();
        final int uvPixelStride = plane[1].getPixelStride();

        ImageConvert.convertYUV420ToARGB8888(
                mYUVBytes[0],
                mYUVBytes[1],
                mYUVBytes[2],
                mRGBBytes,
                image.getWidth(),
                image.getHeight(),
                yRowStride,
                uvRowStride,
                uvPixelStride,
                false);

        Bitmap mRGBframeBitmap = Bitmap.createBitmap(image.getWidth(), image.getHeight(), Bitmap.Config.ARGB_8888);
        mRGBframeBitmap.setPixels(mRGBBytes, 0, image.getWidth(), 0, 0, image.getWidth(), image.getHeight());
        image.close();
    }

