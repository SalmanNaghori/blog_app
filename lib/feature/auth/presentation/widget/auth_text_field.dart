import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObscureText;
  const AuthTextField({super.key, required this.hintText, required this.controller,this.isObscureText=false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscureText,
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText
      ),
      validator: (validate) {
        if (validate!.isEmpty) {
          return "$hintText is missing";
        }
        return null;
      },
    );
  }
}
