import 'package:flutter/material.dart';

import '../../validation_utils.dart';

class SignUpScreen extends StatefulWidget {
  static String routeName = "sign_up_screen";

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
                  validator: (value){
                    if (value!.isEmpty) {
                      return 'Please a Enter Your Name';
                    }
                    if (ValidationUtils.isValidateName(value)==true) {
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
                  validator: (value){
                    if (value!.isEmpty) {
                      return 'Please a Enter Email';
                    }
                    if (ValidationUtils.isValidateEmail(value)==true) {
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
                  validator: (value){
                    if (ValidationUtils.isValidatePassword(value!)==true) {
                      return 'Please a Enter Password';
                    }
                    if(value.length<6){
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
                  height: MediaQuery.of(context).size.height*0.13,
                ),
                Card(
                  elevation: 6,
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color(0xffffffff),
                        borderRadius: BorderRadius.circular(5)),
                    child: InkWell(
                      onTap: () {
                        signIn();
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

  void signIn() {
    if(formKey.currentState?.validate()==false){
      return;
    }
  }
}
