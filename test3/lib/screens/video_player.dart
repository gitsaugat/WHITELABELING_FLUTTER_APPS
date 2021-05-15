import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:primo_flutter_app/models/arguments.dart';
import 'package:primo_flutter_app/models/media.dart';
import 'package:primo_flutter_app/services/login.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController videoPlayerController;
  ChewieController chewieController;
  bool isVideo = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(microseconds: 100), () {
      this.prepareVideo();
    });
  }

  prepareVideo() {
    final VideoPlayerArguments args = ModalRoute.of(context).settings.arguments;
    MediaItem mediaItem = args.mediaItem;

    videoPlayerController = VideoPlayerController.network(mediaItem.file);

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: false,
    );

    int iSeconds = 0;
    int seconds = 0;
    videoPlayerController.addListener(() {
      if (videoPlayerController.value.isPlaying) {
        seconds = videoPlayerController.value.position.inSeconds;
        int value = seconds - iSeconds;
        if (value != 0 && value % 10 == 0) {
          callUpdateDurationAPI(value);
          iSeconds = seconds;
        }
      } else if (videoPlayerController.value.duration ==
          videoPlayerController.value.position) {
        int value = seconds - iSeconds;
        callUpdateDurationAPI(value);
        iSeconds = seconds;
      } else {
        int value = seconds - iSeconds;
        callUpdateDurationAPI(value);
        iSeconds = seconds;
      }
    });

    setState(() {
      isVideo = true;
    });
  }

  callUpdateDurationAPI(int value) async {
    final VideoPlayerArguments args = ModalRoute.of(context).settings.arguments;
    MediaItem mediaItem = args.mediaItem;
    var data = {"watched_duration": value};
    await LoginService().trackMedia(mediaItem.id, data);
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final VideoPlayerArguments args = ModalRoute.of(context).settings.arguments;
    MediaItem mediaItem = args.mediaItem;

    return Scaffold(
      appBar: AppBar(
        title: Text("Video Player"),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                mediaItem.title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            isVideo
                ? Chewie(
                    controller: chewieController,
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ],
        ),
      ),
    );
  }
}
