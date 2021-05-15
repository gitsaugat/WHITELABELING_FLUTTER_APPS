import 'package:primo_flutter_app/models/media.dart';
import 'package:primo_flutter_app/models/quiz_list.dart';

class QuizListArguments {
  final List<QuizListItem> quizList;
  QuizListArguments({this.quizList});
}

class CategoryListArguments {
  final int quizId;
  CategoryListArguments({this.quizId});
}

class VideoListArguments {
  final int categoryId;
  VideoListArguments({this.categoryId});
}

class VideoPlayerArguments {
  final MediaItem mediaItem;
  VideoPlayerArguments({this.mediaItem});
}
