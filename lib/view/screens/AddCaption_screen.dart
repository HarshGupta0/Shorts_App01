import 'dart:io';
import 'package:shorts_app/constants.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';


class addCaption extends StatefulWidget {
  File videoFile;
  String videoPath;

  addCaption({
    Key? key,
    required this.videoFile,
    required this.videoPath,
  }) : super(key: key);

  @override
  State<addCaption> createState() => addCaptionState();
}

class addCaptionState extends State<addCaption> {
  late VideoPlayerController videoPlayerController;
  TextEditingController SongNameController =new TextEditingController();
  TextEditingController CaptionNameController =new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      videoPlayerController = VideoPlayerController.file(widget.videoFile);
    });
    videoPlayerController.initialize();
    videoPlayerController.play();
    videoPlayerController.setLooping(true);
    videoPlayerController.setVolume(.7);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        body: Container(
          margin: EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Column(

      children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.5,
              child: VideoPlayer(videoPlayerController),
            ),
            SizedBox(height: 5,),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  TextField(
                    controller: CaptionNameController,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 6,
                    onTap: (){
                    },
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      labelText:'Caption',
                      icon: Icon(Icons.closed_caption),
                      iconColor: Colors.red.shade50,
                    ),
                  ),
                  SizedBox(
                    height :15,
                  ),
                  TextField(
                    controller: SongNameController,
                    keyboardType: TextInputType.multiline,
                    // keyboardAppearance:,
                    onTap: (){},
                    textInputAction: TextInputAction.done,
                    minLines: 1,
                    maxLines: 6,
                    decoration: InputDecoration(
                      labelText:'Song Name',
                      icon: Icon(Icons.queue_music_sharp,color: Colors.red.shade50,),
                      iconColor: Colors.red.shade50,
                    ),
                  ),
                  SizedBox(height: 12,),
                  ElevatedButton(onPressed:(){}, child:Text("Upload"),style: ElevatedButton.styleFrom(primary: buttonColor),),
                  ],
              ),
            )
      ],
    ),
          ),
        ));
  }
}
