import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class VideoUploadController extends GetxController {
  static VideoUploadController get instance => Get.find<VideoUploadController>();
  Rx<File?> videoFile = Rx<File?>(null);

  void chooseVideo() async {
    final pickedVideoFile =
    await ImagePicker().pickVideo(source: ImageSource.gallery);

    if (pickedVideoFile != null) {
      videoFile.value = File(pickedVideoFile.path);
    }
  }

  Future<void> uploadVideoToFirebase(
      File videoFile, String caption, String songName) async {
    try {
      if (videoFile == null) {
        // Handle case where no video is selected
        return;
      }

      // Reference to the Firebase Storage bucket
      final Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('videos')
          .child(DateTime.now().millisecondsSinceEpoch.toString());

      // Upload the video to Firebase Storage
      await storageReference.putFile(videoFile);

      // Get the download URL of the uploaded video
      String downloadURL = await storageReference.getDownloadURL();

      // Optionally, you can use the download URL for further processing
      print('Video uploaded. DownloadURL: $downloadURL');

      // Optionally, you can perform additional actions or UI updates after video upload
    } catch (e) {
      // Handle errors that occurred during the video upload process
      print('Error uploading video: $e');
    }
  }

  void deleteSelectedVideo() {
    if (videoFile.value != null) {
      try {
        // Delete the selected video file
        videoFile.value!.deleteSync();

        // Clear the selected video file
        videoFile.value = null;

        print('Selected video deleted.');
      } catch (e) {
        print('Error deleting selected video: $e');
      }
    }
  }
}
