import 'package:blog_explorer/bloc/blog_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'services/blog_service.dart';
import 'screens/blog_list_screen.dart';

void main() async {
WidgetsFlutterBinding.ensureInitialized();
await Hive.initFlutter();
await Hive.openBox('blogsBox'); // Open a box for blogs
runApp(BlogExplorerApp());
}

class BlogExplorerApp extends StatelessWidget {
@override
Widget build(BuildContext context) {
return MaterialApp(
debugShowCheckedModeBanner: false,
title: 'Blog Explorer',
theme: ThemeData.dark().copyWith(
scaffoldBackgroundColor: Color(0xFF121212),
primaryColor: Colors.white,

appBarTheme: AppBarTheme(
color: Color(0xFF121212),
elevation: 0,
iconTheme: IconThemeData(color: Colors.white),

),

),
home: BlocProvider(
create: (context) => BlogBloc(blogService: BlogService()),
child: BlogListScreen(),
),
);
}
}
