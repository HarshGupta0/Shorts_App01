import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../Controller/VideoUploadContoller.dart';

class AddCaption extends StatefulWidget {
  final File videoFile;

  AddCaption({
    Key? key,
    required this.videoFile, required String videoPath,
  }) : super(key: key);

  @override
  State<AddCaption> createState() => _AddCaptionState();
}

class _AddCaptionState extends State<AddCaption> {
  late VideoPlayerController _videoPlayerController;
  TextEditingController _songNameController = TextEditingController();
  TextEditingController _captionNameController = TextEditingController();
  bool isUploading = false;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.file(widget.videoFile)
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController.play();
        _videoPlayerController.setLooping(true);
        _videoPlayerController.setVolume(.7);
      });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.5,
                child: VideoPlayer(_videoPlayerController),
              ),
              SizedBox(height: 5),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    TextField(
                      controller: _captionNameController,
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 6,
                      onTap: () {},
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        labelText: 'Caption',
                        icon: Icon(Icons.closed_caption),
                        iconColor: Colors.red.shade50,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: _songNameController,
                      keyboardType: TextInputType.multiline,
                      onTap: () {},
                      textInputAction: TextInputAction.done,
                      minLines: 1,
                      maxLines: 6,
                      decoration: InputDecoration(
                        labelText: 'Song Name',
                        icon: Icon(
                          Icons.queue_music_sharp,
                          color: Colors.red.shade50,
                        ),
                        iconColor: Colors.red.shade50,
                      ),
                    ),
                    SizedBox(height: 12),
                    isUploading?CircularProgressIndicator(color: Colors.white,):
                    ElevatedButton(
                      onPressed: () {
                        uploadVideo();
                      },
                      child:Text("Upload"),
                      // style: ElevatedButton.styleFrom(primary: buttonColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> uploadVideo() async {
    try {
      setState(() {
        isUploading = true;
      });

      // Call the uploadVideoToFirebase method from your VideoUploadController
      await VideoUploadController.instance.uploadVideoToFirebase(
        widget.videoFile,
        _captionNameController.text,
        _songNameController.text,
      );

      // Optionally, you can perform additional actions or UI updates after video upload
      // For example, show a success message, navigate to another screen, etc.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Video uploaded successfully!'),
        ),
      );
    } catch (e) {
      // Handle errors that occurred during the video upload process
      print('Error uploading video: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error uploading video. Please try again.'),
        ),
      );
    } finally {
      setState(() {
        isUploading = false;
        Navigator.pop(context);
      });
    }
  }
}
