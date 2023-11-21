import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shorts_app/Controller/auth_controller.dart';
import 'package:shorts_app/constants.dart';
import 'package:shorts_app/main.dart';
import 'package:shorts_app/view/screens/auth/signupScreen.dart';
import 'package:shorts_app/view/screens/home.dart';
import 'package:shorts_app/view/widgets/Input_Text.dart';
import 'package:shorts_app/view/widgets/glitch.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var authenticationController = AuthenticationController.instanceAuth;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GlithEffect(
                  child: Text(
                "Shorts App",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 35),
              )),
              SizedBox(
                height: 60,
              ),
              InputText(
                controller: emailController,
                myIcon: Icons.email_outlined,
                MylableText: "Email",
              ),
              SizedBox(
                height: 20,
              ),
              InputText(
                controller: passwordController,
                myIcon: Icons.password_sharp,
                toHide: true,
                MylableText: "password",
              ),
              SizedBox(
                height: 50,
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
                  width: 60,
                  child: Text("LOGIN"),
                ),
                style: ElevatedButton.styleFrom(primary: buttonColor),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text("Forget Password ??"),
                    style: TextButton.styleFrom(
                      primary: Colors.white, // Text color
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()));
                    },
                    child: Text(
                      "New User!!",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    style: TextButton.styleFrom(
                      primary: Colors.white, // Text color
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
