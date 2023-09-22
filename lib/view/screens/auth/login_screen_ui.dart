import 'package:flutter/material.dart';
import 'package:shorts_app/constants.dart';
import 'package:shorts_app/main.dart';
import 'package:shorts_app/view/screens/home.dart';
import 'package:shorts_app/view/widgets/Input_Text.dart';
import 'package:shorts_app/view/widgets/glitch.dart';
class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController=new TextEditingController();
  TextEditingController passwordController=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GlithEffect(child: Text("Shorts App",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 30),)),
              SizedBox(height: 30,),
              InputText(controller: emailController,
                  myIcon: Icons.email_outlined, MylableText: "Email",),
              SizedBox(height: 20,),
              InputText(controller: passwordController,
                myIcon: Icons.password_sharp,
                toHide: true,
                MylableText: "password",
              ),
              SizedBox(height: 50,),
              ElevatedButton(onPressed: (){
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Home()));

              } ,child: Container(
                alignment: Alignment.center,
                width: 60,
                child: Text("LOGIN"),
              ),
                style: ElevatedButton.styleFrom(primary:buttonColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
