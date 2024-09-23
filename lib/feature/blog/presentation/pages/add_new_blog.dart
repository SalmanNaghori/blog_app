import 'dart:io';

import 'package:blog_app/core/common/cubits/app_user/app_user_cubit_cubit.dart';
import 'package:blog_app/core/constant/app_string.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/logger_util.dart';
import 'package:blog_app/core/utils/navigation_manager.dart';
import 'package:blog_app/core/utils/pick_image.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/feature/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/feature/blog/presentation/pages/blog_page.dart';
import 'package:blog_app/feature/blog/presentation/widget/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AddNewBlogPage extends StatefulWidget {
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final blogTitleController = TextEditingController();
  final blogDesController = TextEditingController();
  List<String> selectTopic = [];
  File? image;
  final formKey = GlobalKey<FormState>();

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              uploadBlogButtonClick();
            },
            child: const Icon(Icons.done),
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackBar(context, state.error);
            logger.i("Failures");
            EasyLoading.dismiss();
          } else if (state is BlogUploadSuccess) {
            logger.i("Success");

            Future.delayed(const Duration(milliseconds: 1000), () {
              EasyLoading.dismiss();

              navigateToPageAndRemoveAllPages(const BlogPage());
            });
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            logger.i("Loading");
            EasyLoading.show();
          }
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  image != null
                      ? GestureDetector(
                          onTap: selectImage,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                width: double.infinity,
                                child: Image.file(
                                  image!,
                                  fit: BoxFit.cover,
                                )),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            selectImage();
                          },
                          child: DottedBorder(
                            color: AppPalette.borderColor,
                            strokeCap: StrokeCap.round,
                            radius: const Radius.circular(10),
                            borderType: BorderType.RRect,
                            dashPattern: const [10, 4],
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.25,
                              width: double.infinity,
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.folder_open),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    AppString.selectYourImage,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        'Technology',
                        'Business',
                        'Programming',
                        'Entertainment',
                      ]
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: GestureDetector(
                                onTap: () {
                                  if (selectTopic.contains(e)) {
                                    selectTopic.remove(e);
                                  } else {
                                    selectTopic.add(e);
                                  }
                                  setState(() {});
                                  logger.w(selectTopic);
                                },
                                child: Chip(
                                  color: selectTopic.contains(e)
                                      ? const WidgetStatePropertyAll(
                                          AppPalette.gradient1)
                                      : const WidgetStatePropertyAll(
                                          AppPalette.backgroundColor),
                                  label: Text(e),
                                  side: selectTopic.contains(e)
                                      ? null
                                      : const BorderSide(
                                          color: AppPalette.borderColor,
                                        ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BlogEditor(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    textEditingController: blogTitleController,
                    hintText: AppString.blogTitle,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BlogEditor(
                    minLines: null,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    textEditingController: blogDesController,
                    hintText: AppString.blogDescription,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    blogDesController.dispose();
    blogTitleController.dispose();
    super.dispose();
  }

  void uploadBlogButtonClick() {
    try {
      if (formKey.currentState!.validate() &&
          selectTopic.isNotEmpty &&
          image != null) {
        final state = context.read<AppUserCubit>().state;

        if (state is AppUserLoggedIn) {
          final posterId = state.user.id;
          logger.f("posterId:-${posterId}");

          context.read<BlogBloc>().add(BlogUpload(
              posterId: posterId,
              title: blogTitleController.text.trim(),
              content: blogDesController.text.trim(),
              image: image!,
              topics: selectTopic));
        } else {
          // Handle the case where the user is not logged in
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User not logged in')),
          );
        }
      }
    } catch (e) {
      logger.e("Error during blog upload $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Failed to upload the blog. Please try again.')),
      );
    }
  }
}
