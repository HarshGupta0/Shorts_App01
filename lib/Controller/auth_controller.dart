import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shorts_app/view/screens/BottomNavigation.dart';
import '../model/usermodel.dart';
class AuthenticationController extends GetxController
{
  static AuthenticationController instanceAuth =Get.find();
  late Rx<File?> _pickedFile = Rx<File?>(null);
  File ? get profileImage => _pickedFile.value;
  void chooseImageFromGallery()async {
   final pickedImageFile =await ImagePicker().pickImage(source: ImageSource.gallery);
   if(profileImage != null){
     Get.snackbar("Profile Image"," Successfully Selected Profile image");
   }else{
     Get.snackbar("Profile Image","  Successfully Selected");
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

   createAccountForNewUser(File imageFile, String userName, String userEmail, String userPassword,  BuildContext context
      ) async {
    try {
      // 1. Create user in Firebase Auth
      UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );

      // 2. Save the user profile image to Firebase Storage
      String imagedownloadUrl = await uploadProfilePhoto(credential.user!, imageFile);

      // 3. Save user data to the Firestore database
      MyUser user = MyUser(
        name: userName,
        email: userEmail,
        uid: credential.user!.uid,
        profilePhoto: imagedownloadUrl,
      );

      await FirebaseFirestore.instance.collection('users').doc(credential.user!.uid).set(user.toJson());
      Get.snackbar("Account created ", " Welcome ");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
      // Optional: You may perform additional actions or UI updates after account creation.
    } catch (e) {
      // Handle any errors that occurred during the account creation process.
      Get.snackbar("Account creation Failed", "Error Occured ");
      print("Error creating account: $e");
    }
  }

  Future<String> uploadProfilePhoto(User user, File imageFile) async {
    try {
      Reference ref = FirebaseStorage.instance.ref().child('ProfilePics').child(user.uid);
      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      // Handle any errors that occurred during the file upload.
      print("Error uploading profile photo: $e");
      return ""; // You may want to handle this more gracefully in your application.
    }
  }
// user signin method
  Future<void> signInUser(String userEmail, String userPassword, BuildContext context) async {
    try {
      // 1. Sign in user using Firebase Auth
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );

      // 2. Handle successful sign-in (e.g., navigate to the home screen)

      Get.snackbar("Sign In Successful", "Welcome back!");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));

      // Optional: You may perform additional actions or UI updates after sign-in.
    } on FirebaseAuthException catch (e) {
      if (e.code == 'INVALID_LOGIN_CREDENTIALS' || e.code == 'wrong-password') {

        Get.snackbar("SignIn Failed", "Invalid Email or Password.");
      } else {
        Get.snackbar("SignIn Failed", "Error: ${e.message}");
      }
    } catch (e) {
      Get.snackbar("SignIn Failed", "Error: $e");
    }
  }
}