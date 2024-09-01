import 'package:blog_app/core/navigation/global_key.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<dynamic> navigateToPage(Widget routsPage) {
  try {
    FocusManager.instance.primaryFocus?.unfocus();
  } catch (e) {}
  return Navigator.push(
    GlobalVariable.appContext,
    CupertinoPageRoute(builder: (context) => routsPage),
  );
}

Future<dynamic> navigateToPageAndRemoveAllPages(Widget routePage,{Widget? currentWidget}){
  return Navigator.of(GlobalVariable.appContext).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>routePage), (route)=>false);

}