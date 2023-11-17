import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';

import '../model/usermodel.dart';

class AuthenticationController extends GetxController
{
  static AuthenticationController instanceAuth =Get.find();
  late Rx<File?> _pickedFile;
  File ? get profileImage => _pickedFile.value;
  void chooseImageFromGallery()async {
   final pickedImageFile =await ImagePicker().pickImage(source: ImageSource.gallery);
   if(profileImage !=null){
     Get.snackbar("Profile Image"," Successfully Selected Profile image");
   }
    _pickedFile=Rx<File?>(File(pickedImageFile!.path));
  }
  void captureImageWithCamera()async {
    final pickedImageFile =await ImagePicker().pickImage(source: ImageSource.camera);
    if(profileImage !=null){
      Get.snackbar("Profile Image",
          " Successfully Selected Profile image");
    }
    _pickedFile=Rx<File?>(File(pickedImageFile!.path));
  }
  void createAccountForNewUser(File imageFile ,String userName , String userEmail,String userPassword,){

  }
}