import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rx_dart_practise/blog_post_main.dart';
import 'package:rx_dart_practise/view_model/blog_posts_vm.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => BlogPostViewModel());
}

void main() {
  // runApp(const MyApp());

  setupLocator();
  runApp(const BlogPostMain());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

Stream<int> getNumbers() async* {
  for (int i = 0; i <= 10; i++) {
    yield i;
    await Future.delayed(const Duration(seconds: 1));
  }
}

/// Example 3

class HomeModel {
  final StreamController<int> _controller = StreamController<int>.broadcast();
  Stream<int> get outNumbers => _controller.stream;
  Sink<int> get inNumbers => _controller.sink;

  void dispose() {
    _controller.close();
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final model = HomeModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DisplayWidget(
              model: model,
            ),
            ButtonWidget(
              model: model,
            ),
          ],
        ),
      ),
    );
  }
}

class DisplayWidget extends StatelessWidget {
  final HomeModel model;

  const DisplayWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: model.outNumbers,
      builder: (context, snapshot) {
        return Text(
          snapshot.hasData ? snapshot.data.toString() : 'No data',
          style: Theme.of(context).textTheme.headlineMedium,
        );
      },
    );
  }
}

class ButtonWidget extends StatelessWidget {
  final HomeModel model;

  const ButtonWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        model.inNumbers.add(
          Random().nextInt(2000),
        );
      },
      child: const Text('Change Data'),
    );
  }
}

/// Example 2

/*
class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            StreamBuilder<int>(
              stream: getNumbers().map((event) => event * 10),
              builder: (context, snapshot) {
                return Text(
                  snapshot.hasData ? snapshot.data.toString() : 'No data',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}
*/

/// Example 1
/*

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    getNumbers().listen((event) {
      setState(() {
        _counter = event;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}

 */
