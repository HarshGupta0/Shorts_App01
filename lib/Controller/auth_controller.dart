import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';

import '../model/usermodel.dart';

class AuthController extends GetxController {
  File? proImg;

  PickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      proImg = File(image.path);
    }
  }

  Future<void> signUp(String username, String password, String email, File? image) async {
    try {
      if (username.isNotEmpty && password.isNotEmpty && email.isNotEmpty && image != null) {
        UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        String downloadUrl = await _uploadProfilePhoto(image);

        MyUser user = MyUser(name: username, email: email, uid: credential.user!.uid, profilePhoto: downloadUrl);
        await FirebaseFirestore.instance.collection('users').doc(credential.user!.uid).set(user.toJson());
      } else {
        Get.snackbar("Error creating account", "Please fill all fields correctly");
      }
    } catch (e) {
      print(e);
      Get.snackbar("Error Occurred", "Failed to create account. Please try again.");
    }
  }

  Future<String> _uploadProfilePhoto(File image) async {
    Reference ref = FirebaseStorage.instance.ref().child('ProfilePics').child(FirebaseAuth.instance.currentUser!.uid);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }
}
