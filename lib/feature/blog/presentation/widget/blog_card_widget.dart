import 'package:blog_app/core/utils/calculate_reading_time.dart';
import 'package:blog_app/feature/blog/domain/entities/blog.dart';
import 'package:flutter/material.dart';

class BlogCardWidget extends StatelessWidget {
  final Blog blog;
  final Color color;
  const BlogCardWidget({
    super.key,
    required this.blog,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(16).copyWith(bottom: 4),
      height: MediaQuery.of(context).size.height * 0.22,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: blog.topics
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Chip(
                        label: Text(e),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Text(
            blog.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          Spacer(),
          Text("${calculateReadingTime(blog.content)}min")
        ],
      ),
    );
  }
}
