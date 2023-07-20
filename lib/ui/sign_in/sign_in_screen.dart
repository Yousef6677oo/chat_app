import 'package:chat/ui/sign_in/sign_in_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../base/base.dart';
import '../../utilities/validation_utils.dart';
import '../sign_up/sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  static String routeName = "sign_in_screen";

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends BaseState<SignInScreen, SignInViewModel>
    implements SignInNavigator {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool hidePassword = true;
  bool emailIsCorrect = false;
  var formKey = GlobalKey<FormState>();

  @override
  SignInViewModel initViewModel() {
    return SignInViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => viewModel,
      child: Container(
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
              "Login",
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            centerTitle: true,
          ),
          body: Container(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                    ),
                    const Text("Welcome back!",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff303030))),
                    const SizedBox(
                      height: 22,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        emailIsCorrect = false;
                        if (value.length > 8) {
                          if (ValidationUtils.isValidateEmail(value) == false &&
                              value.isNotEmpty) {
                            emailIsCorrect = true;
                          }
                          setState(() {});
                        }
                      },
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
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: const TextStyle(
                          fontSize: 18,
                          color: Color(0xff797979),
                        ),
                        suffix: emailIsCorrect
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: SvgPicture.asset(
                                    "assets/correct_email.svg"),
                              )
                            : const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0),
                                child: Icon(
                                  Icons.email_outlined,
                                  color: Color(0xff7F7F7F),
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (ValidationUtils.isValidatePassword(value!) ==
                            true) {
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
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ImageIcon(
                                    const AssetImage(
                                        "assets/view_password.png"),
                                    color: hidePassword
                                        ? const Color(0xff7F7F7F)
                                        : const Color(0xff3598DB)),
                              )),
                          labelText: "Password",
                          labelStyle: const TextStyle(
                            fontSize: 18,
                            color: Color(0xff797979),
                          )),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    const Text(
                      "Forgot password?",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff303030)),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: const Color(0xff3598DB),
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
                                width: MediaQuery.of(context).size.width * 0.1,
                              ),
                              const Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xffF9F9F9)),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.45,
                              ),
                              const ImageIcon(
                                AssetImage(
                                  "assets/sign_in_arrow.png",
                                ),
                                color: Colors.white,
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, SignUpScreen.routeName);
                        },
                        child: const Text(
                          "Or Create My Account",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  var authService = FirebaseAuth.instance;

  Future<void> signIn() async {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    viewModel.signIn(emailController.text, passwordController.text);
  }
}
