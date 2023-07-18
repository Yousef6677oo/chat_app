import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utilities/dialog_utils.dart';
import '../../utilities/validation_utils.dart';
import '../sign_in/sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  static String routeName = "sign_up_screen";

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool hidePassword = true;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              fit: BoxFit.fill, image: AssetImage("assets/sign_in_bg.png"))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.15,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Create Account",
            style: TextStyle(
                fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please a Enter Your Name';
                    }
                    if (ValidationUtils.isValidateName(value) == false) {
                      return 'Please a Enter Valid Name';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      labelText: "First name",
                      labelStyle: TextStyle(
                        fontSize: 18,
                        color: Color(0xff797979),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please a Enter Email';
                    }
                    if (ValidationUtils.isValidateEmail(value) == true) {
                      return 'Please a Enter Valid Email';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      labelText: "E-mail Address",
                      labelStyle: TextStyle(
                        fontSize: 18,
                        color: Color(0xff797979),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: passwordController,
                  validator: (value) {
                    if (ValidationUtils.isValidatePassword(value!) == true) {
                      return 'Please a Enter Password';
                    }
                    if (value.length < 6) {
                      return 'password should be at least 6 characters';
                    }
                    return null;
                  },
                  obscureText: hidePassword,
                  decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                          onTap: () {
                            if (hidePassword) {
                              hidePassword = false;
                            } else {
                              hidePassword = true;
                            }
                            setState(() {});
                          },
                          child: ImageIcon(
                              const AssetImage("assets/view_password.png"),
                              color: hidePassword
                                  ? const Color(0xff7F7F7F)
                                  : const Color(0xff3598DB))),
                      labelText: "Password",
                      labelStyle: const TextStyle(
                        fontSize: 18,
                        color: Color(0xff797979),
                      )),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.13,
                ),
                Card(
                  elevation: 6,
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color(0xffffffff),
                        borderRadius: BorderRadius.circular(5)),
                    child: InkWell(
                      onTap: () {
                        signUp();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.07,
                            ),
                            const Text(
                              "Create Account",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xffBDBDBD)),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                            ),
                            const ImageIcon(
                              AssetImage(
                                "assets/sign_in_arrow.png",
                              ),
                              color: Color(0xffBDBDBD),
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  var authService = FirebaseAuth.instance;

  Future<void> signUp() async {
    if (formKey.currentState?.validate() == false) {
      return;
    }

    try {
      DialogUtils.showLoading(context);
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      DialogUtils.hideLoading(context);
      Navigator.pushReplacementNamed(context, SignInScreen.routeName);
      //todo: you Should link account with id and name
    } on FirebaseAuthException catch (exception) {
      DialogUtils.hideLoading(context);
      if (exception.code == 'weak-password') {
        DialogUtils.showMyDialog(
            message:
                "weak password. please try another one with character length more than 6",
            context: context);
      } else if (exception.code == 'email-already-in-use') {
        DialogUtils.showMyDialog(
            message: "the email is already in use please try another one",
            context: context);
      }
    } catch (e) {
      DialogUtils.showMyDialog(title: "error", context: context);
    }
  }
}
