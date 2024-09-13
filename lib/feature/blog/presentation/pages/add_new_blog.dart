import 'dart:io';

import 'package:blog_app/core/constant/app_string.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/logger_util.dart';
import 'package:blog_app/core/utils/pick_image.dart';
import 'package:blog_app/feature/blog/presentation/widget/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
            onTap: () {},
            child: const Icon(Icons.done),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          children: [
            image != null
                ? GestureDetector(
                    onTap: selectImage,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                          height: 150,
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
                      child: const SizedBox(
                        height: 150,
                        width: double.infinity,
                        child: Column(
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
                                ? WidgetStatePropertyAll(AppPalette.gradient1)
                                : WidgetStatePropertyAll(
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
              // minLines: 4,
              maxLines: 4,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              textEditingController: blogDesController,
              hintText: AppString.blogDescription,
            ),
          ],
        ),
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
}
