import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool _emailError = false;
  bool _passwordError = false;
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = true;
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return false;
    }
    final emailRegex =
        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$', caseSensitive: false);
    return emailRegex.hasMatch(email);
  }

  bool _validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return false;
    }
    final passwordRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{10,}$');
    return passwordRegex.hasMatch(password);
  }

  Future<void> _signIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    setState(() {
      _emailError = !_validateEmail(email);
      _passwordError = !_validatePassword(password);
    });

    if (_emailError || _passwordError) {
      return;
    }

    //final authResult = await Authentication().signIn(email, password);
    if (true) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Sign In Failed'),
          content: const Text('Invalid email or password'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text(
        'Summarist',
        style: TextStyle(
          color: Colors.black,
          fontSize: 30,
          fontWeight: FontWeight.w700,
        ),
      ),
      backgroundColor: Colors.white,
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(16),
        child: SizedBox(),
      ),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 40),
          const Center(
            child: Text(
              'Welcome!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 24),
          EmailFormField(
            onSaved: (value) => _email = value!,
            validator: (value) =>
                value!.isEmpty ? 'Email field is required' : null,
          ),
          const SizedBox(height: 16),
          PasswordFormField(
            onSaved: (value) => _password = value!,
            validator: (value) =>
                value!.isEmpty ? 'Password field is required' : null,
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              _formKey.currentState!.save();
              if (_formKey.currentState!.validate()) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              minimumSize: const Size(double.infinity, 60),
            ),
            child: const Text('Sign in'),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Don't have any account? "),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'Create one now',
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
}
