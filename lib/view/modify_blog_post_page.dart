import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lorem_gen/lorem_gen.dart';
import 'package:rx_dart_practise/model/blog_post_model.dart';
import 'package:rx_dart_practise/view_model/blog_posts_vm.dart';

class ModifyBlogPage extends StatefulWidget {
  const ModifyBlogPage({
    Key? key,
    this.blogPost,
  }) : super(key: key);

  final BlogPost? blogPost;

  @override
  State<ModifyBlogPage> createState() => _ModifyBlogPageState();
}

class _ModifyBlogPageState extends State<ModifyBlogPage> {
  BlogPostViewModel get _vm => GetIt.I<BlogPostViewModel>();

  late String value;

  @override
  void initState() {
    widget.blogPost == null ? value = '' : value = widget.blogPost!.title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Modify Blog',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
          ),
        ),
        actions: [
          widget.blogPost != null
              ? IconButton(
                  onPressed: () {
                    _vm.deleteBlogPost(widget.blogPost!);
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                )
              : const SizedBox(),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              value,
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          const SizedBox(height: 32.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    value = Lorem.word();
                  });
                },
                child: const Text('Random'),
              ),
              const SizedBox(width: 16.0),
              ElevatedButton(
                onPressed: widget.blogPost == null
                    ? () {
                        _vm.addBlogPost(
                          BlogPost(
                            id: Random().nextInt(1000),
                            title: value,
                            content: Lorem.word(),
                            author: Lorem.word(),
                            publishedDate: DateTime.now(),
                          ),
                        );

                        Navigator.of(context).pop();
                      }
                    : () {
                        _vm.updateBlogPost(
                          BlogPost(
                            id: widget.blogPost!.id,
                            title: value,
                            content: widget.blogPost!.content,
                            author: widget.blogPost!.author,
                            publishedDate: widget.blogPost!.publishedDate,
                          ),
                        );

                        Navigator.of(context).pop();
                      },
                child: widget.blogPost == null
                    ? const Text('Add New Blog')
                    : const Text('Update Blog'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
