import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserVideosScreen extends StatelessWidget {
  final String userId;

  UserVideosScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Videos"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('videos')
            .where('userId', isEqualTo: userId) // Assuming videos are stored with userId
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No videos uploaded yet."));
          }

          return ListView(
            children: snapshot.data!.docs.map((videoDoc) {
              // Assuming videoDoc contains 'title' and 'url'
              return ListTile(
                title: Text(videoDoc['title']),
                onTap: () {
                  // Handle video play action or navigation to video detail page
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
