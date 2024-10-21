import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shorts_app/view/screens/Profile/UserVideos.dart';
import '../../../Controller/auth_controller.dart';
import '../../../model/usermodel.dart';
import '../auth/login_screen_ui.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final AuthenticationController _authController = AuthenticationController.instanceAuth;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  String? _profileImageUrl;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot document = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (document.exists) {
        MyUser myUser = MyUser.fromSnap(document);
        setState(() {
          _nameController.text = myUser.name;
          _emailController.text = myUser.email;
          _phoneNumberController.text = "8505063481"; // Assuming phoneNumber exists
          _profileImageUrl = myUser.profilePhoto; // URL of the profile image
        });
      }
    }
  }

  Future<void> _updateProfile(String field) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    if (field == "name" && _nameController.text.isNotEmpty) {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'name': _nameController.text,
      });
    } else if (field == "email" && _emailController.text.isNotEmpty) {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'email': _emailController.text,
      });
    } else if (field == "phone" && _phoneNumberController.text.isNotEmpty) {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'phoneNumber': _phoneNumberController.text,
      });
    }
    // Reload user data after update
    _loadUserData();
  }

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    Get.to(LoginScreen()); // Redirect to the login screen
  }

  void _chooseImage() async {
    final pickedImageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImageFile != null) {
      // Upload the image to Firebase Storage and get the download URL
      String downloadUrl = await _uploadImageToFirebase(pickedImageFile);
      // Update the Firestore user document with the new profile photo URL
      await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({
        'profilePhoto': downloadUrl,
      });
      setState(() {
        _profileImageUrl = downloadUrl; // Update the profile image URL in the state
      });
    }
  }

  Future<String> _uploadImageToFirebase(XFile pickedImageFile) async {
    // Create a reference to the Firebase Storage
    final storageRef = FirebaseStorage.instance.ref().child('profile_images/${FirebaseAuth.instance.currentUser!.uid}.jpg');

    // Upload the file
    await storageRef.putFile(File(pickedImageFile.path));

    // Get the download URL
    return await storageRef.getDownloadURL();
  }

  void _showEditDialog(String field) {
    String title = "";
    TextEditingController controller = TextEditingController();

    if (field == "name") {
      title = "Edit Name";
      controller.text = _nameController.text;
    } else if (field == "email") {
      title = "Edit Email";
      controller.text = _emailController.text;
    } else if (field == "phone") {
      title = "Edit Phone Number";
      controller.text = _phoneNumberController.text;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(labelText: title),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (field == "name") {
                  _nameController.text = controller.text;
                  _updateProfile("name");
                } else if (field == "email") {
                  _emailController.text = controller.text;
                  _updateProfile("email");
                } else if (field == "phone") {
                  _phoneNumberController.text = controller.text;
                  _updateProfile("phone");
                }
                Navigator.of(context).pop();
              },
              child: Text("Save"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  void _showImageOptions() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Profile Photo"),
          content: Text("Choose an option"),
          actions: [
            TextButton(
              onPressed: () {
                _chooseImage();
                Navigator.of(context).pop();
              },
              child: Text("Change Photo"),
            ),
            TextButton(
              onPressed: () {
                _showEnlargedPhoto();
                Navigator.of(context).pop();
              },
              child: Text("View Photo"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  void _showEnlargedPhoto() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 100,
                  backgroundImage: _profileImageUrl != null
                      ? NetworkImage(_profileImageUrl!)
                      : AssetImage("asset/img.png") as ImageProvider<Object>,
                ),
                SizedBox(height: 20),
                Text(
                  "Profile Photo",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Close"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile"), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _showImageOptions,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _profileImageUrl != null
                    ? NetworkImage(_profileImageUrl!)
                    : AssetImage("asset/img.png") as ImageProvider<Object>,
                child: _profileImageUrl == null
                    ? Icon(Icons.camera_alt, size: 50, color: Colors.grey)
                    : null,
              ),
            ),
            SizedBox(height: 20),
            _buildInfoCard("Name", _nameController.text, () => _showEditDialog("name")),
            SizedBox(height: 10),
            _buildInfoCard("Email", _emailController.text, () => _showEditDialog("email")),
            SizedBox(height: 10),
            _buildInfoCard("Phone Number", _phoneNumberController.text, () => _showEditDialog("phone")),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String userId = FirebaseAuth.instance.currentUser!.uid;
                Get.to(UserVideosScreen(userId: userId)); // Navigate to UserVideosScreen
              },
              child: Text("My Uploaded Videos"),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                minimumSize: Size(double.infinity, 40), // Full width
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: _logout,
                  child: Text("Logout"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    minimumSize: Size(double.infinity, 40), // Full width
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card _buildInfoCard(String title, String subtitle, VoidCallback onEdit) {
    return Card(
      elevation: 4,
      child: ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: IconButton(
          icon: Icon(Icons.edit, color: Colors.blue),
          onPressed: onEdit,
        ),
      ),
    );
  }
}
