import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shorts_app/Controller/auth_controller.dart';
import 'package:shorts_app/constants.dart';
import 'package:shorts_app/firebase_options.dart';
import 'package:shorts_app/view/screens/BottomNavigation.dart';
import 'package:shorts_app/view/screens/auth/login_screen_ui.dart';
import 'Controller/VideoUploadContoller.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) {
    Get.put(AuthenticationController());
    Get.put(VideoUploadController());
  });
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        builder: (BuildContext context, Widget? child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData.dark().copyWith(
              scaffoldBackgroundColor: backgroundColor,
            ),
            home:FirebaseAuth.instance.currentUser==null?LoginScreen():Home(),
          );
        });
  }
}