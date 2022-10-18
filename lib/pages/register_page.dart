// ignore_for_file: prefer_const_constructors

import 'package:chat_app_with_firebase/pages/login_page.dart';
import 'package:chat_app_with_firebase/services/auth_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  bool _isLodaing = false;
  String email = '';
  String password = '';
  String fullName = '';
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLodaing
          ? Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 80,
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        'Groupe!',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Create your account now to chat and explore!',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 15),
                      Image.asset('assets/register.png'),
                      SizedBox(
                        height: 23,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          setState(() {
                            fullName = value;
                          });
                        },
                        validator: (value) {
                          if (value!.isNotEmpty) {
                            return null;
                          } else {
                            return 'Name cannot be empty';
                          }
                        },
                        decoration: textInputDecoration.copyWith(
                          labelText: 'Full Name',
                          prefixIcon: Icon(
                            Icons.person,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                        validator: (value) {
                          return RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value!)
                              ? null
                              : "Please enter a valid email";
                        },
                        decoration: textInputDecoration.copyWith(
                          labelText: 'Email',
                          prefixIcon: Icon(
                            Icons.email,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        obscureText: true,
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                        decoration: textInputDecoration.copyWith(
                          labelText: 'Password',
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        validator: (value) {
                          if (value!.length <= 6) {
                            return 'Password must be at least 6 characters.';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          onPressed: () {
                            register();
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text.rich(TextSpan(
                        text: "Already have an account?",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: " Login now",
                            style: TextStyle(
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                nextScreeen(context, LoginPage());
                              },
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  register() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLodaing = true;
      });

      await authService
          .registerUserWithEmailandPassword(fullName, email, password)
          .then((value) {
        if (value == true) {
          //saving the sharing preference state

        } else {
          showSnackBar(context, Colors.red, value);
          setState(() {
            _isLodaing = false;
          });
        }
      });
    }
  }
}
