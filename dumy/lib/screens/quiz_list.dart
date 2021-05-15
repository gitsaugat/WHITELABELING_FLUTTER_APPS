import 'package:flutter/material.dart';
import 'package:primo_flutter_app/models/arguments.dart';
import 'package:primo_flutter_app/models/quiz_list.dart';

class QuizListScreen extends StatefulWidget {
  @override
  _QuizListScreenState createState() => _QuizListScreenState();
}

class _QuizListScreenState extends State<QuizListScreen> {
  Widget buildQuiz(index, tileHeight) {
    final QuizListArguments args = ModalRoute.of(context).settings.arguments;
    List<QuizListItem> quizList = args.quizList;
    QuizListItem quiz = quizList[index];
    return SizedBox(
      height: tileHeight,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: FlatButton(
          color: Colors.blue,
          child: Text(
            quiz.title,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.of(context).pushNamed("/category-list",
                arguments: CategoryListArguments(quizId: quiz.id));
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double appBarHeight = AppBar().preferredSize.height;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double deviceHeight = MediaQuery.of(context).size.height;
    double screenHeight = deviceHeight - (appBarHeight + statusBarHeight);

    final QuizListArguments args = ModalRoute.of(context).settings.arguments;
    List<QuizListItem> quizList = args.quizList;

    int topicLength = quizList.length;
    double tileHeight = screenHeight / topicLength;

    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz List"),
      ),
      body: Container(
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return buildQuiz(index, tileHeight);
          },
          itemCount: quizList.length,
        ),
      ),
    );
  }
}
