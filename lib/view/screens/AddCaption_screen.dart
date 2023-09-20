import 'dart:io';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class addCaption extends StatefulWidget {
  File videoFile;
  String videoPath;

 addCaption({Key? key,
   required this.videoFile,
   required this.videoPath,
 }) :super(key: key);

  @override
  State<addCaption> createState() => addCaptionState();
}

class addCaptionState extends State<addCaption> {
 late VideoPlayerController videoPlayerController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      videoPlayerController =VideoPlayerController.file(widget.videoFile);
    });
    videoPlayerController.initialize();
    videoPlayerController.play();
    videoPlayerController.setLooping(true);
    videoPlayerController.setVolume(.7);


  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height,
          child:VideoPlayer(videoPlayerController),
          )
        ],
      )
    );
  }
}
