import 'package:flutter/material.dart';
import 'package:primo_flutter_app/screens/category_list.dart';
import 'package:primo_flutter_app/screens/login.dart';
import 'package:primo_flutter_app/screens/quiz_list.dart';
import 'package:primo_flutter_app/screens/video_list.dart';
import 'package:primo_flutter_app/screens/video_player.dart';

class Routes {
  final routes = <String, WidgetBuilder>{
    '/': (BuildContext context) => LoginScreen(),
    '/category-list': (BuildContext context) => CategoryListScreen(),
    '/quiz-list': (BuildContext context) => QuizListScreen(),
    '/video-list': (BuildContext context) => VideoListScreen(),
    '/video-player': (BuildContext context) => VideoPlayerScreen(),
  };
}
