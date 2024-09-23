import 'dart:async';
import 'dart:io';

import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/feature/blog/domain/entities/blog.dart';
import 'package:blog_app/feature/blog/domain/usecase/get_all_blog.dart';
import 'package:blog_app/feature/blog/domain/usecase/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlog _getAllBlog;
  BlogBloc({
    required UploadBlog uploadBlogs,
    required GetAllBlog getAllBlog,
  })  : _uploadBlog = uploadBlogs,
        _getAllBlog = getAllBlog,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>(_blogUpload);
    on<BlogsFetchAllBlog>(_fetchAllBlog);
  }
  void _blogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    final res = await _uploadBlog(
      UploadBlogParams(
        posterId: event.posterId,
        title: event.title,
        content: event.content,
        image: event.image,
        topics: event.topics,
      ),
    );
    res.fold(
      (l) => emit(BlogFailure(l.message)),
      (r) => emit(
        BlogUploadSuccess(),
      ),
    );
  }

  FutureOr<void> _fetchAllBlog(
      BlogsFetchAllBlog event, Emitter<BlogState> emit) async {
    final res = await _getAllBlog(NoParams());

    res.fold((l) => emit(BlogFailure(l.message)),
        (r) => emit(BlogDisplaySuccess(r)));
  }
}
