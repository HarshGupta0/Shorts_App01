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
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController setpasswordController = TextEditingController();
  TextEditingController ConfirmpasswordController = TextEditingController();

  var authenticationController = AuthenticationController.instanceAuth;
  bool isLoading = false; // Track loading state

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
                      fontSize: 33.sp,
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
                InkWell(
                  onTap: () {
                    authenticationController.chooseImageFromGallery();
                  },
                  child: Stack(
                    children: [
                      CircleAvatar(
                        backgroundImage: authenticationController.profileImage != null
                            ? FileImage(authenticationController.profileImage!)
                            : AssetImage("asset/img.png") as ImageProvider,
                        radius: 60,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                          onPressed: () {
                            authenticationController.chooseImageFromGallery();
                          },
                          icon: Icon(
                            Icons.camera_alt,
                            size: 34.h,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                InputText(
                  controller: usernameController,
                  myIcon: Icons.person_3_outlined,
                  MylableText: "USER NAME",
                ),
                SizedBox(height: 20.h),
                InputText(
                  controller: emailController,
                  myIcon: Icons.email_outlined,
                  MylableText: "EMAIL",
                ),
                SizedBox(height: 20.h),
                InputText(
                  controller: setpasswordController,
                  myIcon: Icons.password_sharp,
                  toHide: true,
                  MylableText: "Set Password",
                ),
                SizedBox(height: 20.h),
                InputText(
                  controller: ConfirmpasswordController,
                  myIcon: Icons.password_sharp,
                  toHide: true,
                  MylableText: "Confirm Password",
                ),
                SizedBox(height: 50.h),
                isLoading // Show loading indicator if signing up
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                  onPressed: () async {
                    // Check if the profile image is selected
                    if (authenticationController.profileImage == null) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Profile Image Required"),
                          content: Text("Please select a profile image before signing up."),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("OK"),
                            ),
                          ],
                        ),
                      );
                    } else if (setpasswordController.text.isNotEmpty &&
                        usernameController.text.isNotEmpty &&
                        emailController.text.isNotEmpty) {
                      setState(() {
                        isLoading = true; // Set loading state
                      });

                      // Call the async method to create an account
                      await authenticationController.createAccountForNewUser(
                        authenticationController.profileImage!,
                        usernameController.text,
                        emailController.text,
                        setpasswordController.text,
                        context,
                      );

                      setState(() {
                        isLoading = false; // Reset loading state after operation
                      });
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 65.w,
                    child: Text("Register"),
                  ),
                  style: ElevatedButton.styleFrom(primary: buttonColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
