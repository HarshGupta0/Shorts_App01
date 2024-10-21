import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shorts_app/view/screens/Add_videos.dart';
import 'package:shorts_app/view/screens/Profile/ProfileView.dart';
const backgroundColor =Colors.black;
var buttonColor =Colors.red[400];
const borderColor =Colors.grey;
var pageindex=[
  Text('home'),
  Text('search'),
  addVideoScreen(),
  Text('message'),
  ProfileView()
];
getRandomColor() => [
  Colors.blueAccent,
  Colors.redAccent,
  Colors.greenAccent,
][Random().nextInt(3)];