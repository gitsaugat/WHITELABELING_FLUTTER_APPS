import 'package:flutter/material.dart';
import 'package:primo_flutter_app/models/arguments.dart';
import 'package:primo_flutter_app/models/category.dart';
import 'package:primo_flutter_app/services/login.dart';

import 'package:primo_flutter_app/widgets/custom_tile.dart' as custom;

class CategoryListScreen extends StatefulWidget {
  @override
  _CategoryListScreenState createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  bool showLoading = false;
  List<CategoryItem> categoryList = [];

  void setLoading(bool loading) {
    setState(() {
      showLoading = loading;
    });
  }

  @override
  void initState() {
    super.initState();
    setLoading(true);
    Future.delayed(Duration(milliseconds: 10), () {
      this.getCategories();
    });
  }

  getCategories() async {
    List<CategoryItem> cList = [];

    final CategoryListArguments args =
        ModalRoute.of(context).settings.arguments;

    var cateData = await LoginService().getCategories(args.quizId);
    var categories = cateData["categories"];
    if (categories != null && categories.length > 0) {
      for (var category in categories) {
        CategoryItem categoryItem = CategoryItem(
            title: category["title"],
            isExpanded: false,
            subCategories: [],
            color: Colors.blue);
        for (var subCategory in category["child"]) {
          categoryItem.subCategories.add(SubCategoryItem(
              id: subCategory["id"], title: subCategory["title"]));
        }
        cList.add(categoryItem);
      }
    }

    setLoading(false);
    setState(() {
      categoryList = cList;
    });
  }

  onPressSubCategory(id) {
    Navigator.of(context).pushNamed("/video-list",
        arguments: VideoListArguments(categoryId: id));
  }

  List<Widget> buildSubCategories(List<SubCategoryItem> subtopics, int index) {
    List<Widget> list = List();
    Color textColor = Colors.white;
    for (var subtopic in subtopics) {
      list.add(Padding(
        padding: const EdgeInsets.only(left: 20),
        child: ListTile(
          title: Row(
            children: <Widget>[
              Flexible(
                child: GestureDetector(
                  onTap: () {
                    this.onPressSubCategory(subtopic.id);
                  },
                  child: Text(
                    subtopic.title,
                    style: TextStyle(fontSize: 16, color: textColor),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ],
          ),
        ),
      ));
    }
    return list;
  }

  Widget buildCategory(index, tileHeight) {
    CategoryItem topic = categoryList[index];
    Color textColor = Colors.white;
    return Container(
      color: topic.color,
      child: custom.ExpansionTile(
        headerBackgroundColor: topic.color,
        headerHeight: tileHeight,
        backgroundColor: topic.color,
        initiallyExpanded: false,
        iconColor: textColor,
        title: Text(
          topic.title,
          style: TextStyle(fontSize: 17, color: textColor),
        ),
        children: buildSubCategories(topic.subCategories, index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double appBarHeight = AppBar().preferredSize.height;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double deviceHeight = MediaQuery.of(context).size.height;
    double screenHeight = deviceHeight - (appBarHeight + statusBarHeight);

    int topicLength = categoryList.length;
    double tileHeight = screenHeight / topicLength;
    double itemThreshold = 6;
    double itemSizeBelowThreshold = 7;

    if (topicLength < itemThreshold) {
      tileHeight = screenHeight / itemSizeBelowThreshold;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Category List"),
      ),
      body: !showLoading
          ? Container(
              child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return buildCategory(index, tileHeight);
              },
              itemCount: categoryList.length,
            ))
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
