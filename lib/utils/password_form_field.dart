import 'package:flutter/material.dart';

class PasswordFormField extends StatelessWidget {
  final TextEditingController? controller;
  final bool? obscureText;
  final VoidCallback? onTap;

  const PasswordFormField({Key? key, this.controller, this.obscureText, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: 'Password',
        border: const OutlineInputBorder(),
        suffixIcon: GestureDetector(
          onTap: onTap,
          child: Icon(
            obscureText! ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password field is required';
        } else if (value.length < 10) {
          return 'Password must be at least 10 characters long';
        } else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])').hasMatch(value)) {
          return 'Password must contain at least one uppercase letter, one lowercase letter, and one number';
        }
        return null;
      },
      obscureText: obscureText!,
    );
  }
}
