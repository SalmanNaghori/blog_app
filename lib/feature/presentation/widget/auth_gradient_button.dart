import 'package:blog_app/core/constant/app_string.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AuthGradientButton extends StatelessWidget {
  final String buttonTitle;
  final Function onPress;
  const AuthGradientButton({super.key, required this.buttonTitle, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          AppPallete.gradient1,
          AppPallete.gradient2,
        ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
      ),borderRadius: BorderRadius.circular(7)),
      child: ElevatedButton(
        onPressed: () {
          onPress();
        },
        style: ElevatedButton.styleFrom(
          fixedSize: Size(double.infinity, 50),
          backgroundColor: AppPallete.transparentColor,
          shadowColor: AppPallete.transparentColor,
        ),
        child: Center(
          child: Text(
            buttonTitle,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
