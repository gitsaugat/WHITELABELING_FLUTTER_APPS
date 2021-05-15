import 'package:primo_flutter_app/utils/config.dart';

import 'session.dart';

class LoginService {
  final session = Session();

  Future getToken(data) async {
    var url = Urls.Token;
    final response = await session.post(url, data);
    return response;
  }

  Future getQuizId() async {
    var url = Urls.QuizList;
    final response = await session.get(url);
    return response;
  }

  Future getCategories(quizId) async {
    var url = Urls.Categories + "$quizId";
    final response = await session.get(url);
    return response;
  }

  Future getMedia(categoryId) async {
    var url = Urls.Media + "$categoryId";
    final response = await session.get(url);
    return response;
  }

  Future trackMedia(id, data) async {
    var url = Urls.Media + "track/$id/";
    final response = await session.post(url, data);
    return response;
  }
}
