import 'dart:async';
import 'dart:math';

import 'package:rx_dart_practise/model/blog_post_model.dart';

class BlogPostViewModel {
  final StreamController<List<BlogPost>> _blogPostListController =
      StreamController<List<BlogPost>>.broadcast();
  Stream<List<BlogPost>> get outBlogPostList => _blogPostListController.stream;
  Sink<List<BlogPost>> get inBlogPostList => _blogPostListController.sink;

  List<BlogPost> _blogPosts = [];

  BlogPostViewModel() {
    outBlogPostList.listen((event) {
      _blogPosts = event;
    });
  }

  void addBlogPost(BlogPost blogPost) {
    _blogPosts.add(blogPost);
    inBlogPostList.add(_blogPosts);
  }

  void updateBlogPost(BlogPost blogPost) {
    var index =
        _blogPosts.indexWhere((element) => element.content == blogPost.content);
    _blogPosts.removeAt(index);
    _blogPosts.insert(index, blogPost);
    inBlogPostList.add(_blogPosts);
  }

  void deleteBlogPost(BlogPost blogPost) {
    _blogPosts.removeWhere((element) => element.title == blogPost.title);
    inBlogPostList.add(_blogPosts);
  }
}
