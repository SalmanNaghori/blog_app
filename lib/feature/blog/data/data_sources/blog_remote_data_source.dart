import 'dart:io';

import 'package:blog_app/feature/blog/data/model/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blog);
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blogModel,
  });
}

class BlogRemoteDataSourceImp extends BlogRemoteDataSource {
  final SupabaseClient supabaseClient;

  BlogRemoteDataSourceImp(this.supabaseClient);
  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final blogData =
          await supabaseClient.from('blogs').insert(blog.toJson()).select();
      return BlogModel.fromJson(blogData.first);
    } catch (e) {
      throw e;
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
      throw e;
    }
  }
}
