import 'package:flutter/material.dart';
import 'package:nannyish/main.dart';
import 'package:nannyish/firebase/fb_auth_controller.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  TextEditingController Email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  bool Progress = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: double.infinity,
                ),
                const SizedBox(
                  height: 20,
                ),
                Image.asset(
                  'assets/logo.jpg',
                  height: 150,
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 280,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: Email,
                        decoration: InputDecoration(
                          fillColor: Color(0xFFEEEEEE),
                          filled: true,
                          border: InputBorder.none,
                          hintText: 'E-mail',
                          hintStyle: TextStyle(
                            fontFamily: 'TimesNewRoman',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: password,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                            fontFamily: 'TimesNewRoman',
                            fontWeight: FontWeight.w600,
                          ),
                          fillColor: Color(0xFFEEEEEE),
                          filled: true,
                          border: InputBorder.none,
                          hintText: 'password',
                        ),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 4.0,
                        ),

                        child: GestureDetector(
                          onTap: () {
                            print('navigating to ForgetPasswordScreen');
                            Navigator.pushNamed(context, 'forgetPassword');
                          },
                          child: Text(
                            'Forget password',
                            style: TextStyle(fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'TimesNewRoman',
                            ),
                          ),
                        ),
                      ),

                      Divider(
                        thickness: 2,
                        color: Color.fromARGB(255, 10, 10, 10),
                        endIndent: 175,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 220,
                  child: ElevatedButton(
                    onPressed: () {
                      if (Email.text.isNotEmpty && password.text.isNotEmpty) {
                        FbAuthController().signIn(context,
                            email: Email.text.trim(), password: password.text);
                      } else {
                        if (Email.text.isEmpty && password.text.isNotEmpty) {
                          showMaterialDialog_login(
                              context, "please enter your email");
                        }
                        if (password.text.isEmpty && Email.text.isNotEmpty) {
                          showMaterialDialog_login(
                              context, "please enter your password");
                        }
                        if (Email.text.isEmpty && password.text.isEmpty) {
                          showMaterialDialog_login(
                              context, "please enter your log in information");
                        }
                      }
                    },
                    child: Progress == false
                        ? Text('Log in')
                        : CircularProgressIndicator(
                            color: Colors.white,
                          ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      elevation: 0,
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'TimesNewRoman',
                        fontSize: 19,

                      ),
                      primary: Color(0xFF455A64),
                      shape: const RoundedRectangleBorder(
                          borderRadius: const BorderRadius.all(Radius.zero)),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: 190,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'registerParent');
                        },
                        child: const Text('Register as a parent'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 17),
                          elevation: 0,
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'TimesNewRoman',
                            fontSize: 19,
                          ),
                          primary: Color(0xFF455A64),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.zero)),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          Navigator.pushNamed(context, 'registerNanny');
                        },
                        child: const Text('Register as a nanny'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 17),
                          elevation: 0,
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontFamily: 'TimesNewRoman',
                          ),
                          primary: const Color(0xFF455A64),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.zero)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
