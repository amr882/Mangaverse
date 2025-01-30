import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangaverse/auth/servers/auth_server.dart';
import 'package:mangaverse/widgets/button.dart';
import 'package:sizer/sizer.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  Future<void> sendEmailVerification() async {
    AuthServer.sendEmailVerification();
  }

  @override
  void initState() {
    sendEmailVerification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 35.h,
              child: Text(
                "We have sent you email verification",
                textAlign: TextAlign.center,
                maxLines: 3,
                style: GoogleFonts.rubik(
                    color: Colors.white,
                    fontSize: 4.h,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Button(
              width: double.infinity,
              onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  'SignIn',
                  (route) => false,
                );
              },
              title: 'Go LogIn',
            )
          ],
        ),
      ),
    );
  }
}
