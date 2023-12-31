import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shorts_app/Controller/auth_controller.dart';
import 'package:shorts_app/constants.dart';
import 'package:shorts_app/view/screens/auth/signupScreen.dart';
import 'package:shorts_app/view/widgets/Input_Text.dart';
import 'package:shorts_app/view/widgets/glitch.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var authenticationController = AuthenticationController.instanceAuth;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin :EdgeInsets.symmetric(horizontal: 10.w),
          padding:EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GlithEffect(
                  child: Text(
                "Shorts App",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 35.sp),
              )),
              SizedBox(
                height: 60.h,
              ),
              InputText(
                controller: emailController,
                myIcon: Icons.email_outlined,
                MylableText: "Email",
              ),
              SizedBox(
                height: 20.h,
              ),
              InputText(
                controller: passwordController,
                myIcon: Icons.password_sharp,
                toHide: true,
                MylableText: "password",
              ),
              SizedBox(
                height: 50.h,
              ),
              ElevatedButton(
                onPressed: () {
                  // Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Home()));
                  if (emailController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty) {
                    authenticationController.signInUser(
                        emailController.text, passwordController.text, context);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 60.w,
                  child: Text("LOGIN",style: TextStyle(fontWeight:FontWeight.w500,fontSize: 15.sp),),
                ),
                style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text("Forget Password ??",style: TextStyle(fontWeight:FontWeight.w500,fontSize: 16.sp),),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white, // Text color
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()));
                    },
                    child:Text(
                      "New User!!",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white, // Text color
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
