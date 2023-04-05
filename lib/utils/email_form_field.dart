import 'package:flutter/material.dart';

class EmailFormField extends StatelessWidget {
  final TextEditingController? controller;

  const EmailFormField({Key? key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email field is required';
        } else if (!value.contains('@')) {
          return 'Please enter a valid email address';
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
    );
  }
}
