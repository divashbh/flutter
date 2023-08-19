import 'package:chat/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterUser extends StatefulWidget {
  static String route = "RegisterUser";
  const RegisterUser({Key? key}) : super(key: key);

  @override
  _RegisterUserState createState() => _RegisterUserState();
}

final fnameController = TextEditingController();
final lnameController = TextEditingController();
final emailController = TextEditingController();
final passwordController = TextEditingController();

String radioClickedValue = "";
bool? checkBoxValue1 = false;
bool? checkBoxValue2 = false;

class _RegisterUserState extends State<RegisterUser> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    fnameController.text = "Flutter";
    lnameController.text = "Flutter";
    emailController.text = "flutter@flutter.com";
    passwordController.text = "flutter123";
    super.initState();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register User'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Container(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "First Name",
                      prefixIcon: Icon(Icons.supervised_user_circle),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                      hintText: 'First Hint Hint Name',
                    ),
                    controller: fnameController,
                    obscureText: false,
                    validator: (first_name) {
                      if (first_name == null || first_name.isEmpty) {
                        return "First name is required";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: TextFormField(
                    controller: lnameController,
                    maxLines: 1,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Field cannot be empty";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Last Name",
                      prefixIcon: Icon(Icons.supervised_user_circle),
                      border: OutlineInputBorder(),
                      hintText: 'Last Name',
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
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
                Text(radioClickedValue),
                Text(checkBoxValue1.toString()),
                Column(
                  children: <Widget>[
                    Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            leading: Radio(
                              value: "male",
                              groupValue: radioClickedValue,
                              onChanged: (clickedItemName) {
                                setState(() {
                                  radioClickedValue = clickedItemName!;
                                });
                              },
                            ),
                            title: Text("Male"),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            leading: Radio(
                              value: "female",
                              groupValue: radioClickedValue,
                              onChanged: (clickedItemName) {
                                setState(() {
                                  radioClickedValue = clickedItemName!;
                                });
                              },
                            ),
                            title: Text("Female"),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: checkBoxValue1,
                            activeColor: Colors.black,
                            checkColor: Colors.white,
                            onChanged: (newValue) {
                              setState(() {
                                checkBoxValue1 = newValue;
                              });
                            }),
                        Text(
                          'I accept the terms and conditions',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text('Register'),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        registerUser();
                      }
                    },
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already Registered",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 7),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void registerUser() async {
    // Future<UserCredential>
    final registeredUser = await firebaseAuth.createUserWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
    if (registeredUser != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
      showFlutterToast();
    } else {
      print("Failed to register");
      // snackbar
      // toast
    }
  }

  void showFlutterToast() {
    Fluttertoast.showToast(
        msg: "Successfully Registered", toastLength: Toast.LENGTH_LONG);
  }
}

/*

Stateless Widgets
1 - Intro about Stateless widget
2 - How to add Image in Flutter
3 - How to add Icons in Flutter
4 - How to create a Container in Flutter
5 - How to create Buttons in Flutter
6 - How to create Appbar in Flutter
7 - Row, Column and Expanded Widget in Flutter
8 - How to create ListView in Flutter
9 -  ListView.builder in flutter
10 - Navigation Drawer in Flutter
11 - Floating Action button in Flutter
12 - Stack Layout Widget in Flutter
13 - How to create custom Widgets in Flutter



14 - What are Stateful Widgets in Flutter
15 - Flutter Navigation Push Pop
16 - Text_field and TextForm_Field in Flutter
17 - Checkbox in Flutter
18 - Radio Button in Flutter
19 - Dropdown Button in Flutter
 */
