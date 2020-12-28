import 'package:buy_it_store/common/constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Function onClick;
  final TextEditingController controller;

  const CustomTextField({
    Key key,
    this.hint,
    this.icon,
    this.onClick,
    this.controller,
  }) : super(key: key);

  String _errorMessage(String value) {
    switch (hint) {
      case HintConstants.name:
        return "Name is empty";
      case HintConstants.email:
        return "Enter your email";
      case HintConstants.password:
        return "Password is Empty";
      default:
        return "Enter valid data";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value.isEmpty) {
            return _errorMessage(value);
          }
        },
        onSaved: onClick,
        obscureText: hint == HintConstants.password ? true : false,
        cursorColor: Constants.kMainColor,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(
            icon,
            color: Constants.kMainColor,
          ),
          filled: true,
          fillColor: Constants.kSecondaryColor,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white)),
        ),
      ),
    );
  }
}
