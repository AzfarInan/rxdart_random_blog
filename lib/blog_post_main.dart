import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rx_dart_practise/view/blog_post_list_page.dart';
import 'package:rx_dart_practise/view/modify_blog_post_page.dart';

class BlogPostMain extends StatelessWidget {
  const BlogPostMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog Posts',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const BlogPostListPage(),
    );
  }
}
