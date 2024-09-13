import 'dart:io';

import 'package:blog_app/core/utils/logger_util.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> pickImage() async {
  try {
    final xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      return File(xFile.path);
    } else {
      return null;
    }
  } catch (e) {
    logger.e("Issue coming in to pick image$e");
    return null;
  }
}
