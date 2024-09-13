import 'package:blog_app/core/utils/navigation_manager.dart';
import 'package:blog_app/feature/blog/presentation/pages/add_new_blog.dart';
import 'package:blog_app/feature/blog/presentation/widget/blog_editor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Blog App"),
        actions: [
          GestureDetector(
            onTap: () {
              navigateToPage(AddNewBlogPage());
            },
            child: Icon(
              CupertinoIcons.add_circled,
            ),
          ),
        ],
      ),
    );
  }
}
