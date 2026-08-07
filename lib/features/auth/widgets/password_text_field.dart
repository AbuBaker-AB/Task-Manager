import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputAction textInputAction;

  const PasswordTextField({
    super.key,
    required this.controller,
    this.hintText = "Password",
    this.textInputAction = TextInputAction.done,
  });

  @override
  State<PasswordTextField> createState() =>
      _PasswordTextFieldState();
}

class _PasswordTextFieldState
    extends State<PasswordTextField> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      textInputAction: widget.textInputAction,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: IconButton(
          onPressed: _toggleVisibility,
          icon: Icon(
            _obscureText
                ? Icons.visibility_off
                : Icons.visibility,
          ),
        ),
      ),
    );
  }
}