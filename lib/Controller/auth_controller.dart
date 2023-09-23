import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shorts_app/model/usermodel.dart';

class Authcontroller extends GetxController {
  File? proimg;
  Authcontroller instance = Get.find();
  PickImage()async{
    final image =  await ImagePicker().pickImage(source: ImageSource.gallery);
    if(image==null)
      return;
    final img = File(image.path);
    this.proimg=img;
  }
  void SignUp(
    String Username,
    String Password,
    String email,
    File? image,
  ) async {
    try {
      if (Username.isNotEmpty &&
          Password.isNotEmpty &&
          email.isNotEmpty &&
          image != null) {
        UserCredential credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: Password);
        _upLoadProfilePhoto(image);
        String downlaodUrl = await _upLoadProfilePhoto(image);
        MyUser user  = MyUser(name: Username, email: email, uid:credential.user!.uid, profilePhoto:downlaodUrl);
        //upload kr raha hei users data ko,
        await FirebaseFirestore.instance.collection('users').doc(credential.user!.uid).set(user.toJson());
      }else{
        Get.snackbar("Error creating account ","Please correctly fill all the fields");
      }
    } catch (e) {
      print(e);
      Get.snackbar("Error Occurred", e.toString());
    }
  }

  Future<String> _upLoadProfilePhoto(File image) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('ProfilePics')
        .child(FirebaseAuth.instance.currentUser!.uid);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snapshot = await uploadTask;
    String imgDwnUrl = await snapshot.ref.getDownloadURL();
    return imgDwnUrl;
  }
}
