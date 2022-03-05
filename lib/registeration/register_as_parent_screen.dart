// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:nannyish/main.dart';
import 'package:nannyish/firebase/fb_auth_controller.dart';
import 'package:nannyish/users.dart';

class RegisterAsParentScreen extends StatefulWidget {
  const RegisterAsParentScreen({Key? key}) : super(key: key);

  @override
  State<RegisterAsParentScreen> createState() => _RegisterAsParentScreenState();
}

class _RegisterAsParentScreenState extends State<RegisterAsParentScreen> {
  TextEditingController Email = new TextEditingController();
  TextEditingController Name = new TextEditingController();
  TextEditingController Identity_ID = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController confirmPassword = new TextEditingController();

var formKey = GlobalKey<FormState>();

  bool Progress = false;

  var Gender;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 110,
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/logo.jpg',
                        ),
                        Text(
                          'Welcome to Nannyish',
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'TimesNewRoman',

                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    width: 280,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Please fill these Information:',
                          style: TextStyle(fontSize: 18,
                            fontFamily: 'TimesNewRoman',

                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Identity ID:',
                          style: TextStyle(fontSize: 18,
                            fontFamily: 'TimesNewRoman',

                          ),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          validator: ( value){
                            if (value!.isEmpty){
                              return 'please enter your Identity ID';
                            }
                          },
                          controller: Identity_ID,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 10,
                            ),
                            fillColor: Color(0xFFEEEEEE),
                            filled: true,
                            border: InputBorder.none,
                            hintText: 'Identity ID:',
                            hintStyle: TextStyle(
                              fontFamily: 'TimesNewRoman',
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Email:',
                          style: TextStyle(fontSize: 18,
                            fontFamily: 'TimesNewRoman',

                          ),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          validator: ( value){
                            if (value!.isEmpty){
                              return 'please enter your email';
                            }
                          },
                          controller: Email,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 10,
                            ),
                            fillColor: Color(0xFFEEEEEE),
                            filled: true,
                            border: InputBorder.none,
                            hintText: 'Email',
                            hintStyle: TextStyle(
                              fontFamily: 'TimesNewRoman',
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'First and last name:',
                          style: TextStyle(fontSize: 18,
                            fontFamily: 'TimesNewRoman',

                          ),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(

                          validator: ( value){
                            if (value!.isEmpty){
                              return 'please enter your name';
                            }
                          },
                          controller: Name,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 10,
                            ),
                            fillColor: Color(0xFFEEEEEE),
                            filled: true,
                            border: InputBorder.none,
                            hintText: 'First and last name',
                            hintStyle: TextStyle(
                              fontFamily: 'TimesNewRoman',
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Password:',
                          style: TextStyle(fontSize: 18,
                            fontFamily: 'TimesNewRoman',

                          ),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          validator: ( value){
                            if (value!.isEmpty){
                              return 'please enter your password';
                            }
                          },
                          controller: password,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 10,
                            ),
                            fillColor: Color(0xFFEEEEEE),
                            filled: true,
                            border: InputBorder.none,
                            hintText: 'Password',
                            hintStyle: TextStyle(
                              fontFamily: 'TimesNewRoman',
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Confirm Password:',
                          style: TextStyle(fontSize: 18,
                            fontFamily: 'TimesNewRoman',

                          ),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          validator: ( value){
                            if (value!.isEmpty){
                              return 'please confirm your password';
                            }
                            if (password.text != confirmPassword.text){
                              return "Password Do not match";
                            }
                          },
                          controller: confirmPassword,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 10,
                            ),
                            fillColor: Color(0xFFEEEEEE),
                            filled: true,
                            border: InputBorder.none,
                            hintText: 'Confirm Password',
                            hintStyle: TextStyle(
                              fontFamily: 'TimesNewRoman',
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Gender:',
                          style: TextStyle(fontSize: 18,
                            fontFamily: 'TimesNewRoman',

                          ),
                        ),
                        const SizedBox(height: 5),
                        DropdownButtonFormField(
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.black,
                            ),
                            hint: const DropdownMenuItem(
                              child: Text('Female or male',
                                style: TextStyle(
                                  fontFamily: 'TimesNewRoman',

                                ),

                              ),
                            ),
                            onChanged: (v) {
                              setState(() {
                                Gender = v;
                              });
                            },
                            decoration: const InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 10,
                              ),
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Color(0xFFEEEEEE),
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: 0,
                                child: Text('Male',
                                  style: TextStyle(
                                    fontFamily: 'TimesNewRoman',

                                  ),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 1,
                                child: Text('Female',
                                  style: TextStyle(
                                    fontFamily: 'TimesNewRoman',

                                  ),
                                ),
                              ),
                            ]),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          if (!Progress) {
                            createAccount(
                                email: Email.text, password: password.text);
                          }
                        }
                      },
                      child: Progress == false
                          ? Text(
                              'Register',
                              style: TextStyle(fontSize:22,
                                fontFamily: 'TimesNewRoman',

                              ),
                            )
                          : CircularProgressIndicator(
                              color: Colors.white,
                            ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        elevation: 0,
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'TimesNewRoman',
                        ),
                        primary: Color(0xFF455A64),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.zero)),
                      ),
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

  void createAccount({required String email, required String password}) async {
    if (Email.text.trim().isNotEmpty && Gender != null && password.isNotEmpty) {
      loadingDialog(context, true);
      Users user = Users.data(
          name: Name.text,
          email: Email.text.trim(),
          type: 'Parent',
          identityID: Identity_ID.text,
          gender: Gender.toString() == '0' ? "Male" : "Female",
          photoUrl: '');
      bool statusAuth = await FbAuthController()
          .createAccount(context, users: user, password: password);

      if (statusAuth) {
        loadingDialog(context, false);
      }
      // else {
      //   showMaterialDialog_login(context, "please try later");
      //   print('please try later');
      // }
    } else {
      showMaterialDialog_login(context, "please enter data correctly");
    }
  }

  void loadingDialog(BuildContext context, bool run) {
    if (run)
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Center(
              child: CircularProgressIndicator(),
            );
          });
    else {
      // Navigator.pop(context);
      Navigator.of(context)
        ..pop()
        ..pop()
        ..pop();
    }
  }
}
