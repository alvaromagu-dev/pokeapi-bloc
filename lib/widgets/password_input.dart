import 'dart:developer';

import 'package:check_install/utils/int_extensions.dart';
import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({
    Key? key, this.controller, this.prefixIcon, this.labelText,
    this.border,
  }) : super(key: key);

  final TextEditingController? controller;
  final Widget? prefixIcon;
  final String? labelText;
  final InputBorder? border;

  @override
  State<StatefulWidget> createState() {
    return PasswordInputState();
  }
}

class PasswordInputState extends State<PasswordInput> {
  bool isHidden = true;

  void toggleVisibility() => setState(() => isHidden = !isHidden);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isHidden,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if(value == null || value.isEmpty){
          return 'Field can\'t be empty';
        }

        if(value.length < 5){
          return 'Min length is 5!';
        }

        if(!value.codeUnits.any((element) => element.isDigit)){
          return 'Password must contain 1 digit';
        }

        if(!value.codeUnits.any((element) => element.isLetter)){
          return 'Password must contain 1 letter';
        }

        return null;
      },
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: toggleVisibility,
          icon: Icon(isHidden ? Icons.visibility_off : Icons.visibility),
        ),
        prefixIcon: widget.prefixIcon,
        labelText: widget.labelText,
        border: widget.border,
      ),
    );
  }
}