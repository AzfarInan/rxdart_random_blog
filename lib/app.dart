import 'package:flutter/material.dart';
import 'package:rx_dart_practise/view/blog_post_list_page.dart';

final ValueNotifier<String> env = ValueNotifier<String>('production');

class App extends StatefulWidget {
  const App({
    Key? key,
    required this.flavor,
  }) : super(key: key);

  final String flavor;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    widget.flavor.contains('Development')
        ? env.value = 'development'
        : env.value = 'production';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog Posts - ${widget.flavor}',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlogPostListPage(
        flavor: widget.flavor,
      ),
    );
  }
}
