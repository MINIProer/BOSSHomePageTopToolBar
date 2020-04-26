import 'dart:ui';

class JRScreenFitTool {
  static double physicalWidth;
  static double physicalHeight;
  static double dpr;
  static double screenWidth;
  static double screenHeight;
  static double rpx;
  static double px;
  static double statusBarHeight;
  static const double navBarHeight = 44.0;

  static void initialize({double standarSize = 750}) {
    physicalWidth = window.physicalSize.width;
    physicalHeight = window.physicalSize.height;

    dpr = window.devicePixelRatio;

    screenWidth = physicalWidth / dpr;
    screenHeight = physicalHeight / dpr;

    rpx = screenWidth / standarSize;
    px = screenWidth / standarSize * 2;
  }

  static double setRpx(double size) {
    return rpx * size;
  }

  static double setPx(double size) {
    return px * size;
  }

  static double setStatusBarHeight(double size) {
    print('size = $size');
    statusBarHeight = size;
    return size;
  }
}
