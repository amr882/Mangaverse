import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangaverse/auth/view/lets_you_in.dart';
import 'package:mangaverse/widgets/button.dart';
import 'package:sizer/sizer.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -60,
            left: -40.w,
            child: Image.asset(
              "assets/Auto Layout Horizontal.png",
              height: 130.h,
              fit: BoxFit.cover,
            ),
          ),
          SvgPicture.asset(
            'assets/Rectangle.svg',
            height: 120.h,
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 35.h,
                  child: Text(
                    'Welcome to Mangaverse',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.rubik(
                        color: Colors.white,
                        fontSize: 4.h,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 50.w.h,
                  child: Text(
                    'The best streaming manga app of the century to entertain you every day',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: GoogleFonts.rubik(
                      color: Colors.white,
                      fontSize: 1.8.h,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 3.h),
                  child: Button(
                    width: double.infinity,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const LetsYouIn()));
                    },
                    title: 'Get Started',
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
