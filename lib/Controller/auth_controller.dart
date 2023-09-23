import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
class Authcontroller extends GetxController{
 void SignUp(
     String Username,
     String Password,
     String email,
     File image,
     )async{
   try{
     if(Username.isNotEmpty && Password.isNotEmpty && email.isNotEmpty && image!=null){
       UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: Password);
       _upLoadProfilePhoto(image);
     }
   }catch(e){
     print(e);
     Get.snackbar("Error Occurred", e.toString());
   }

 }
 Future<String> _upLoadProfilePhoto(File image) async{
   Reference ref = FirebaseStorage.instance.ref().child('ProfilePics').child(FirebaseAuth.instance.currentUser!.uid);
   UploadTask uploadTask =ref.putFile(image);
   TaskSnapshot snapshot = await uploadTask;
   String imgDwnUrl = await snapshot.ref.getDownloadURL();
   return imgDwnUrl;

 }
}