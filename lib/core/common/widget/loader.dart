import 'package:blog_app/core/utils/logger_util.dart';
import 'package:blog_app/core/utils/lottie_animation_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Loader {
  Loader._();
  static final instance = Loader._();

  init() {
    logger.f("Inside loader init");

    EasyLoading.instance
      ..indicatorWidget =
          const LottieAnimationWidget() // Custom Lottie animation
      ..indicatorColor =
          Colors.transparent // Set to transparent or any color you prefer
      ..displayDuration = const Duration(milliseconds: 2000)
      ..backgroundColor = Colors.transparent
      ..indicatorSize = 60
      ..loadingStyle = EasyLoadingStyle.custom // Ensure custom style is used
      ..maskType = EasyLoadingMaskType.custom
      ..backgroundColor = Colors.transparent
      // ..maskColor = Colors.transparent
      ..dismissOnTap = false
      ..textColor = Colors.transparent
      ..maskColor = Colors.black54
      // ..textColor = Colors.transparent
      ..boxShadow = <BoxShadow>[]; //!remove background
    // ..userInteractions = false;
  }
}
