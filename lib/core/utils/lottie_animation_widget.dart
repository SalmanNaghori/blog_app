import 'package:blog_app/core/constant/app_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieAnimationWidget extends StatefulWidget {
  const LottieAnimationWidget({super.key});

  @override
  State<LottieAnimationWidget> createState() => _LottieAnimationWidgetState();
}

class _LottieAnimationWidgetState extends State<LottieAnimationWidget> {
  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      ImageAssets.icBlogAnimation,
      repeat: true,
      height: 200,
      width: 200,
    );
  }
}
