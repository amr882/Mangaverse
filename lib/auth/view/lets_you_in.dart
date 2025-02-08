import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangaverse/auth/servers/auth_server.dart';
import 'package:mangaverse/auth/view/sign_in.dart';
import 'package:mangaverse/auth/view/sign_up.dart';
import 'package:mangaverse/widgets/button.dart';
import 'package:mangaverse/widgets/continue_with.dart';
import 'package:sizer/sizer.dart';

class LetsYouIn extends StatefulWidget {
  const LetsYouIn({super.key});

  @override
  State<LetsYouIn> createState() => _LetsYouInState();
}

class _LetsYouInState extends State<LetsYouIn> {
  googleSignIn() async {
    AuthServer.signInWithGoogle(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff16161c),
      body: Stack(
        children: [
          Positioned(
            top: -4.5.h,
            left: -8.2.h,
            child: Image.asset(
              'assets/jujutsu-kaisen-wallpapers.jpg',
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
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Let's you in",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.rubik(
                      color: Colors.white,
                      fontSize: 3.5.h,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 3.h,
                ),
                ContinueWith(
                  onTap: () {},
                  continueWithImage: 'assets/twitter.svg',
                  methodName: 'Twitter',
                  imageHeight: 3.5,
                ),
                ContinueWith(
                  onTap: () {
                    googleSignIn();
                  },
                  continueWithImage: 'assets/google.svg',
                  methodName: 'Google',
                  imageHeight: 4,
                ),
                ContinueWith(
                  onTap: () {},
                  continueWithImage: 'assets/apple.svg',
                  methodName: 'Apple ID',
                  imageHeight: 3.9,
                ),

                // or create account

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          color: Color(0xff3f4040),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: Text(
                          'or',
                          style: GoogleFonts.rubik(
                              color: Colors.white, fontSize: 2.h),
                        ),
                      ),
                      const Expanded(
                        child: Divider(
                          color: Color(0xff3f4040),
                        ),
                      ),
                    ],
                  ),
                ),
                Button(
                    width: double.infinity,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SignIn()));
                    },
                    title: 'SIGN IN WITH PASSWORD'),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don’t have an account?",
                      style: GoogleFonts.rubik(color: Colors.white),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
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
                  height: 2.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
