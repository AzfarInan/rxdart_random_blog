import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rx_dart_practise/app.dart';
import 'package:rx_dart_practise/model/blog_post_model.dart';
import 'package:rx_dart_practise/view/modify_blog_post_page.dart';
import 'package:rx_dart_practise/view_model/blog_posts_vm.dart';

class BlogPostListPage extends StatelessWidget {
  const BlogPostListPage({
    Key? key,
    required this.flavor,
  }) : super(key: key);

  final String flavor;

  BlogPostViewModel get _vm => GetIt.I<BlogPostViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Blog Posts - $flavor',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: StreamBuilder<List<BlogPost>>(
        stream: _vm.outBlogPostList,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return env.value == 'development' ? const Center(
              child: Text('No Data'),
            ) : const Center(
              child: CircularProgressIndicator(),
            );
          }

          final blogPosts = snapshot.data as List<BlogPost>;

          return ListView.builder(
            itemCount: blogPosts.length,
            itemBuilder: (context, index) {
              final blogPost = blogPosts[index];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ModifyBlogPage(
                        blogPost: blogPost,
                      ),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    margin: const EdgeInsets.only(top: 8.0),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 8.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          blogPost.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          blogPost.publishedDate.toLocal().toString(),
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ModifyBlogPage(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
