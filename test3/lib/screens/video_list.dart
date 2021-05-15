import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:primo_flutter_app/models/arguments.dart';
import 'package:primo_flutter_app/models/media.dart';
import 'package:primo_flutter_app/services/login.dart';

class VideoListScreen extends StatefulWidget {
  @override
  _VideoListScreenState createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
  bool showLoading = false;
  List<MediaItem> mediaList = [];

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
      this.getVideos();
    });
  }

  getVideos() async {
    List<MediaItem> cList = [];

    final VideoListArguments args = ModalRoute.of(context).settings.arguments;
    var mediaData = await LoginService().getMedia(args.categoryId);

    if (mediaData != null && mediaData.length > 0) {
      for (var media in mediaData) {
        MediaItem mediaItem = MediaItem(
            title: media["name"],
            id: media["id"],
            ext: media["extension"],
            file: media["file"],
            percentage: media["watched_percentage"]);
        cList.add(mediaItem);
      }
    }

    setLoading(false);
    setState(() {
      mediaList = cList;
    });
  }

  Widget buildMediaList(index) {
    MediaItem mediaItem = mediaList[index];
    return Container(
      padding: EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed("/video-player",
              arguments: VideoPlayerArguments(mediaItem: mediaItem));
        },
        child: Card(
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Icon(
                  Icons.ondemand_video,
                  size: 50,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  mediaItem.title,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 20,
                ),
                LinearPercentIndicator(
                  lineHeight: 15.0,
                  percent: mediaItem.percentage / 100,
                  backgroundColor: Colors.black12,
                  progressColor: Colors.blue,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Video List"),
        ),
        body: !showLoading
            ? Container(
                padding: EdgeInsets.all(15),
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return buildMediaList(index);
                  },
                  itemCount: mediaList.length,
                ))
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
