import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DetailsPage extends StatelessWidget {
  final String manga_photo;
  final String manga_titel;
  const DetailsPage(
      {super.key, required this.manga_photo, required this.manga_titel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 100.w,
                height: 35.h,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(200, 255, 255, 255),
                        spreadRadius: 50,
                        blurRadius: 20,
                        offset: Offset(0, 3)),
                  ],
                ),
                child: Image.network(
                  manga_photo,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: 100.w,
                height: 36.h,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Color.fromARGB(160, 255, 255, 255),
                      Colors.white
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(2.h),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        manga_photo,
                        height: 27.5.h,
                        width: 35.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Column(
                      children: [
                        SizedBox(
                            width: 50.w,
                            child: Text(
                              manga_titel,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
