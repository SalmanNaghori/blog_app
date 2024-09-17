import 'package:flutter/material.dart';

class BlogEditor extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final int? maxLines;
  final int? minLines;

  const BlogEditor({
    super.key,
    required this.textEditingController,
    required this.hintText,
    required this.textInputAction,
    required this.keyboardType,
    this.maxLines,
    this.minLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // minLines: minLines ?? 1,
      maxLines: null,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      validator: (value) {
        if (value!.trim().isEmpty) {
          return '$hintText is missing';
        }
        return null;
      },
    );
  }
}
