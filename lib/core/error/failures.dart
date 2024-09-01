import 'package:blog_app/core/constant/app_string.dart';

class Failure {
  final String message;
  Failure([this.message = AppString.anUnexpectedErrorOccur]);
}
