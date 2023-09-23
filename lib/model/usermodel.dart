import 'dart:html';
import 'dart:js_interop';

import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser{
  String email;
  String name;
  String profilePhoto;
  String uid;
  MyUser({
    required this.name ,
    required this.email,
    required this.uid,
    required this.profilePhoto,

});
  //App (data)--> firebase
  Map<String , dynamic> toJson ()=>{
      "name":name,
      "profilePhoto":profilePhoto,
      "email":email,
      "uid":uid,
    };
  // firebase --> app(user)//
  static MyUser fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String , dynamic>;
    return MyUser(
        name: snapshot['name'],
        email: snapshot['email'],
        uid: snapshot['uid'],
        profilePhoto: snapshot['profilePhoto']);
  }
}