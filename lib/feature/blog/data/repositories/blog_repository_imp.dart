import 'dart:io';

import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/utils/logger_util.dart';
import 'package:blog_app/feature/blog/data/data_sources/blog_remote_data_source.dart';
import 'package:blog_app/feature/blog/data/model/blog_model.dart';
import 'package:blog_app/feature/blog/domain/entities/blog.dart';
import 'package:blog_app/feature/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImp implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;

  BlogRepositoryImp(this.blogRemoteDataSource);

  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topic, // Ensure parameter name matches
  }) async {
    try {
      final blogId = Uuid().v1(); // Generate UUID for the blog

      BlogModel blogModel = BlogModel(
        id: blogId,
        posterId: posterId,
        title: title,
        content: content,
        imageUrl: '',
        topics: topic,
        updatedAt: DateTime.now(),
      );

      // logger.i("BlogModel before image upload: ${blogModel.toJson()}");

      final imageUrl = await blogRemoteDataSource.uploadBlogImage(
        image: image,
        blogModel: blogModel,
      );

      blogModel = blogModel.copyWith(imageUrl: imageUrl);

      // logger.i("BlogModel after image upload: ${blogModel.toJson()}");

      final uploadedBlog = await blogRemoteDataSource.uploadBlog(blogModel);
      return right(uploadedBlog);
    } on ServerExceptions catch (e) {
      logger.e("Server error: ${e.message}");
      return left(Failure(e.message));
    } catch (e) {
      logger.e("Unexpected error: $e");
      return left(Failure("Unexpected error occurred."));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlog() async {
    try {
      final blog = await blogRemoteDataSource.getAllBlogs();

      return right(blog);
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }
}
