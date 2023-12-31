import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shorts_app/Controller/auth_controller.dart';
import 'package:shorts_app/view/widgets/glitch.dart';
import '../../../constants.dart';
import '../../widgets/Input_Text.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController usernameController = new TextEditingController();
  TextEditingController setpasswordController = new TextEditingController();
  TextEditingController ConfirmpasswordController = new TextEditingController();
  var authenticationController = AuthenticationController.instanceAuth;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GlithEffect(
                    child: Text(
                  "Welcome!!",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 33.sp
                  ),
                )),
                SizedBox(
                  height: 30.h,
                ),
                InkWell(
                  onTap: (){
                     // AuthController().instance.proim
                  },
                  child:Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage("asset/img.png"),
                      radius: 60,
                    ),
                    Positioned(
                        bottom: 0,
                        // top: 0,
                        right: 0,
                        // left: 0,
                        child: IconButton(
                          onPressed: () {
                            authenticationController.chooseImageFromGallery();
                          },
                          icon: Icon(
                            Icons.camera_alt,
                            size: 34.h,
                          ),
                        )),
                  ],
                ) ,),
                SizedBox(
                  height: 30.h,
                ),
                InputText(
                  controller: usernameController,
                  myIcon: Icons.person_3_outlined,
                  MylableText: "USER NAME",
                ),
                SizedBox(
                  height: 20.h,
                ),
                InputText(
                  controller: emailController,
                  myIcon: Icons.email_outlined,
                  MylableText: "EMAIL",
                ),
                SizedBox(
                  height: 20.h,
                ),
                InputText(
                  controller: setpasswordController,
                  myIcon: Icons.password_sharp,
                  toHide: true,
                  MylableText: "Set Password",
                ),
                SizedBox(
                  height: 20.h,
                ),
                InputText(
                  controller: ConfirmpasswordController,
                  myIcon: Icons.password_sharp,
                  toHide: true,
                  MylableText: "Confirm Password",
                ),
                SizedBox(
                  height: 50.h,
                ),
                ElevatedButton(
                  onPressed: () {
                    if(setpasswordController.text.isNotEmpty
                        && usernameController.text.isNotEmpty
                        && emailController.text.isNotEmpty
                    ){
                      authenticationController.createAccountForNewUser(
                        authenticationController.profileImage!,
                        usernameController.text,
                        emailController.text,
                        setpasswordController.text,
                        context
                      );
                    }
                    // if(authenticationController.createAccountForNewUser()){}
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 65.w,
                    child: Text(" Register "),
                  ),
                  style: ElevatedButton.styleFrom(primary: buttonColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
