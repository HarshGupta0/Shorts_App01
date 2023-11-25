import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class VideoUploadController extends GetxController {
  Rx<File?> videoFile = Rx<File?>(null);

  void chooseVideo() async {
    final pickedVideoFile =
    await ImagePicker().pickVideo(source: ImageSource.gallery);

    if (pickedVideoFile != null) {
      videoFile.value = File(pickedVideoFile.path);
    }
  }

  Future<void> uploadVideoToFirebase() async {
    try {
      if (videoFile.value == null) {
        // Handle case where no video is selected
        return;
      }

      // Reference to the Firebase Storage bucket
      final Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('videos')
          .child(DateTime.now().millisecondsSinceEpoch.toString());

      // Upload the video to Firebase Storage
      await storageReference.putFile(videoFile.value!);

      // Get the download URL of the uploaded video
      String downloadURL = await storageReference.getDownloadURL();

      // Optionally, you can use the download URL for further processing
      print('Video uploaded. DownloadURL: $downloadURL');

      // Clear the selected video file
      videoFile.value = null;

      // Optionally, you can perform additional actions or UI updates after video upload
    } catch (e) {
      // Handle errors that occurred during the video upload process
      print('Error uploading video: $e');
    }
  }
}
