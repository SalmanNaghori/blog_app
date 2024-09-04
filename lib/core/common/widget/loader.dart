import 'package:blog_app/core/utils/logger_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Loader {
  Loader._();
  static final instance = Loader._();

  init() {
    logger.f("Inside loader init");
    // EasyLoading.init();
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..loadingStyle =
          EasyLoadingStyle.custom //This was missing in earlier code
      ..backgroundColor = Colors.transparent
      ..indicatorColor = Colors.white
      ..indicatorType = EasyLoadingIndicatorType.dualRing
      ..indicatorSize = 60
      ..maskType = EasyLoadingMaskType.black
      ..dismissOnTap = false
      ..textColor = Colors.transparent
      ..boxShadow = <BoxShadow>[]
      ..userInteractions = false;

  }
}
