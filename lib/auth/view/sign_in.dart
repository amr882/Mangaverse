// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangaverse/auth/servers/auth_server.dart';
import 'package:mangaverse/auth/view/sign_up.dart';
import 'package:mangaverse/widgets/button.dart';
import 'package:mangaverse/widgets/text_form.dart';

import 'package:sizer/sizer.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //keys
  GlobalKey<FormState> emailFormState = GlobalKey();
  GlobalKey<FormState> passwordFormState = GlobalKey();

  //bool
  bool showPassword = true;
  bool rememberMe = false;

  showHidePassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  Future<void> signInWithEmailAndPassword() async {
    AuthServer.signInWithEmailAndPassword(
      emailController.text,
      passwordController.text,
    );
    Navigator.of(context).pushNamedAndRemoveUntil(
      "LatestManga",
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          backgroundColor: const Color(0xff16161c),
          body: Stack(
            children: [
              Positioned(
                left: 0,
                child: Image.asset(
                  "assets/jujutsu-kaisen-wallpapers.jpg",
                  height: 120.h,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: -21.h,
                child: SvgPicture.asset(
                  'assets/Rectangle (1).svg',
                  height: 120.h,
                  fit: BoxFit.cover,
                ),
              ),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: SizedBox(
                  height: 100.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 35.h,
                        child: Text(
                          'Login to your account',
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          style: GoogleFonts.rubik(
                              color: Colors.white,
                              fontSize: 4.h,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 2.4.h,
                      ),
                      //email
                      TextForm(
                        formState: emailFormState,
                        obscureText: false,
                        controller: emailController,
                        textInputType: TextInputType.emailAddress,
                        hintText: 'Enter your email here',
                        prefixIcon: SvgPicture.asset(
                          'assets/Subtract.svg',
                          height: 2.h,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'not valid.';
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return 'enter valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      //password
                      TextForm(
                        formState: passwordFormState,
                        obscureText: showPassword,
                        controller: passwordController,
                        textInputType: TextInputType.name,
                        hintText: 'Enter Password',
                        prefixIcon: SvgPicture.asset(
                          'assets/lock.svg',
                          height: 2.h,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: showHidePassword,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            height: 2.h,
                            width: 2.h,
                            child: SvgPicture.asset(
                              showPassword
                                  ? 'assets/eyeHidePassword.svg'
                                  : 'assets/EyeShowPassword.svg',
                              height: 2.h,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'not valid.';
                          }
                          return null;
                        },
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: Row(
                          children: [
                            Checkbox(
                              side: const BorderSide(color: Colors.white),
                              activeColor: const Color(0xff05c149),
                              value: rememberMe,
                              onChanged: (val) {
                                setState(() {
                                  rememberMe = val!;
                                });
                              },
                            ),
                            Text(
                              'Remember me',
                              style: GoogleFonts.rubik(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Button(
                        width: double.infinity,
                        onTap: () {
                          if (emailFormState.currentState!.validate() &&
                              passwordFormState.currentState!.validate()) {
                            signInWithEmailAndPassword();
                            print('done');
                          } else {
                            print('valid');
                          }
                        },
                        title: 'LOGIN',
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => ForgetPassword()));
                        },
                        child: Text(
                          'Forget the password',
                          style: GoogleFonts.rubik(
                              color: const Color(0xff05c149),
                              fontWeight: FontWeight.bold),
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don’t have an account?",
                            style: GoogleFonts.rubik(color: Colors.white),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => const SignUp()));
                            },
                            child: Text(
                              'Sign Up',
                              style: GoogleFonts.rubik(
                                  color: const Color(0xff05c149),
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      )
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
