import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rx_dart_practise/app.dart';
import 'package:rx_dart_practise/view_model/blog_posts_vm.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => BlogPostViewModel());
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PackageInfo.fromPlatform();

  setupLocator();
  runApp(
    const App(flavor: 'Production'),
  );
}
