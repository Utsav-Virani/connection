import 'dart:convert';
import 'package:connection/config/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:connection/screens/HomeView.dart';

class SignUp extends StatefulWidget {

  final Function toggleView;
  SignUp(this.toggleView);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

  AuthMethods _authMethod = AuthMethods();

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  userSignUp() {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      _authMethod
          .signUpWithEmail(_emailController.text, _passwordController.text)
          .then((value) {
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => HomeView(),
        ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height - 50,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.1),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image(
                      image: new AssetImage("lib/assets/logo_trans.png"),
                      fit: BoxFit.cover,
                      height: 300,
                    ),
                    // SizedBox(height: 10,),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: TextFormField(
                              validator: (value) {
                                return value.isEmpty || value.length < 3
                                    ? "Invalid UserName"
                                    : null;
                              },
                              controller: _userNameController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'User ID:',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: TextFormField(
                              validator: (val) {
                                return RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(val)
                                    ? null
                                    : "Enter correct email";
                              },
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'Email ID:',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: TextFormField(
                              obscureText: true,
                              controller: _passwordController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'Password:',
                              ),
                              validator: (val) {
                                return val.length < 6
                                    ? "Enter Password 6+ characters"
                                    : null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    GestureDetector(
                      onTap: () {
                        userSignUp();
                      },
                      child: SizedBox(
                        child: Container(
                          // onPressed: _saveForm,
                          width: MediaQuery.of(context).size.width * 0.45,
                          padding: EdgeInsets.symmetric(
                            vertical: 15,
                          ),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff2A75BC).withOpacity(0.2),
                                blurRadius: 5.0,
                                spreadRadius: 1.0,
                                offset: Offset(
                                  4.0,
                                  4.0,
                                ),
                              ),
                            ],
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xff007EF4),
                                const Color(0xff2A75BC),
                              ],
                            ),
                          ),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have account? ",
                          // style: simpleTextStyle(),
                        ),
                        GestureDetector(
                          onTap: () {
                            widget.toggleView();
                          },
                          child: Text(
                            "Login now",
                            style: TextStyle(
                              // color: Colors.white,
                                fontSize: 16,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
