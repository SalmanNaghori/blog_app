import 'dart:io';

import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/utils/logger_util.dart';
import 'package:blog_app/feature/blog/data/model/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blog);
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blogModel,
  });
  Future<List<BlogModel>> getAllBlogs();
}

class BlogRemoteDataSourceImp extends BlogRemoteDataSource {
  final SupabaseClient supabaseClient;

  BlogRemoteDataSourceImp(this.supabaseClient);
  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final blogData = await supabaseClient
          .from('blogs')
          .insert(blog.toMap())
          .select('*'); // Explicitly select all columns
      final blogMap = blog.toMap();
      logger.i("Inserting blog with data: $blogMap");
      if (blogData.isNotEmpty) {
        return BlogModel.fromJson(blogData.first);
      } else {
        logger.e("Failed to insert blog: No data returned.");
        throw Exception("Failed to insert blog: No data returned.");
      }
    } catch (e) {
      logger.e("Error uploading blog: $e");
      throw Exception("Error uploading blog: $e");
    }
  }

  @override
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blogModel,
  }) async {
    try {
      await supabaseClient.storage
          .from("blog_images")
          .upload(blogModel.id, image);
      return supabaseClient.storage
          .from("blog_images")
          .getPublicUrl(blogModel.id);
    } catch (e) {
      logger.e("Error uploading Image: $e");
      throw e;
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      final blog =
          await supabaseClient.from('blogs').select('*, profiles (name)');
      final response = blog
          .map((blog) => BlogModel.fromJson(blog)
              .copyWith(posterName: blog['profiles']['name']))
          .toList();
      logger.f("Response==getAllBlogs: $response");
      return response;
    } catch (e) {
      logger.e("getAllBlogs==${e.toString()}");
      throw ServerExceptions(e.toString());
    }
  }
}
