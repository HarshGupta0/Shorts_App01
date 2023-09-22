import 'package:flutter/material.dart';
import 'package:shorts_app/constants.dart';
class InputText extends StatelessWidget {
  final TextEditingController controller;
  final bool toHide ;
  final IconData myIcon;
  final String MylableText;
  InputText({Key? key,
    required this.controller,
    required this.myIcon,
    required this.MylableText,
    this.toHide=false,
  }) : super(key: key);

  @override

  Widget build(BuildContext context) {
    return TextField(
      obscureText: toHide,
      controller:controller,
      decoration: InputDecoration(
        icon: Icon(myIcon),
        labelText: MylableText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color:borderColor,
          )
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color:borderColor,
            )
        ),
      ),
    );
  }
}
