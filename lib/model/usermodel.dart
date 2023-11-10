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
  //App (data)--> firebase (converting to json format)
  Map<String , dynamic> toJson ()=>{
      "name":name,
      "profilePhoto":profilePhoto,
      "email":email,
      "uid":uid,
    };
  // firebase --> app(user)//
  static MyUser fromSnap(DocumentSnapshot snap){
    var datasnapshot = snap.data() as Map<String , dynamic>;
    return MyUser(
        name: datasnapshot['name'],
        email: datasnapshot['email'],
        uid: datasnapshot['uid'],
        profilePhoto: datasnapshot['profilePhoto']);
  }
}