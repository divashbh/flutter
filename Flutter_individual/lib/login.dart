import 'package:chat/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

import 'chat_screen.dart';

class LoginScreen extends StatefulWidget {
  static String route = "LoginScreen";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final _formKey = GlobalKey<FormState>();

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final emailController = TextEditingController(text: "flutter@flutter.com");
  final passwordController = TextEditingController(text: "flutter123");

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: TextFormField(
                      autofocus: true,
                      controller: emailController,
                      maxLines: 1,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Field cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(Icons.supervised_user_circle),
                        border: OutlineInputBorder(),
                        hintText: 'Email',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: TextFormField(
                      obscureText: true,
                      controller: passwordController,
                      maxLines: 1,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Field cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: Icon(Icons.password),
                        border: OutlineInputBorder(),
                        hintText: 'Password',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text('Login'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          loginUser();
                        }
                      },
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text('Register'),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterUser()));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void loginUser() async {
    // Future<UserCredential>
    final result = await firebaseAuth.signInWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
    if (result != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ChatScreen()));
      showMotionSuccessToast();
    } else {
      print("Failed to register");
      // snackbar
      // toast
    }
  }

  void showMotionSuccessToast() {
    MotionToast.success(description: Text("Login Success")).show(context);
  }
}
