import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/navigation_manager.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/feature/blog/domain/entities/blog.dart';
import 'package:blog_app/feature/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/feature/blog/presentation/pages/add_new_blog.dart';
import 'package:blog_app/feature/blog/presentation/pages/blog_viewer_page.dart';
import 'package:blog_app/feature/blog/presentation/widget/blog_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogsFetchAllBlog());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Blog App"),
        actions: [
          GestureDetector(
            onTap: () {
              navigateToPage(const AddNewBlogPage());
            },
            child: const Icon(
              CupertinoIcons.add_circled,
            ),
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackBar(context, state.error);
            EasyLoading.dismiss();
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            EasyLoading.show();
          }
          if (state is BlogDisplaySuccess) {
            EasyLoading.dismiss();
            return ListView.builder(
                itemCount: state.blogs.length,
                itemBuilder: (context, index) {
                  final blog = state.blogs[index];
                  return GestureDetector(
                    onTap: () {
                      gotoBlogViewerPage(blog);
                    },
                    child: BlogCardWidget(
                      blog: blog,
                      color: index % 3 == 0
                          ? AppPalette.gradient1
                          : index % 3 == 1
                              ? AppPalette.gradient2
                              : AppPalette.gradient3,
                    ),
                  );
                });
          }
          return const SizedBox();
        },
      ),
    );
  }

  void gotoBlogViewerPage(Blog blog) {
    navigateToPage(BlogViewerPage(
      blog: blog,
    ));
  }
}
