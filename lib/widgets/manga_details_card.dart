import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class MangaDetailsCard extends StatelessWidget {
  final String manga_photo;
  final String manga_titel;
  final String status;
  final int create_at;
  final String summary;
  final List genres;
  final int total_chapter;
  final List authors;
  final String time;
  const MangaDetailsCard(
      {super.key,
      required this.manga_photo,
      required this.manga_titel,
      required this.status,
      required this.create_at,
      required this.summary,
      required this.genres,
      required this.total_chapter,
      required this.authors,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      width: 90.w,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 243, 243, 243),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(50, 0, 0, 0),
            spreadRadius: 5,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            summary,
            style: GoogleFonts.notoSans(
                color: Color(0xff777777), fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 2.h,
          ),
          Wrap(
            children: List.generate(
              genres.length,
              (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Chip(
                    shape: StadiumBorder(
                        side: BorderSide(color: Colors.transparent)),
                    color: WidgetStatePropertyAll(
                      Color(0xffe9e9e9),
                    ),
                    padding: EdgeInsets.all(6),
                    label: Text(
                      genres[index],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("started at:\n$time"),
                Text("total chapters:\n$total_chapter"),
              ],
            ),
          ),
          Text(
              "authors : \n${authors.toString().replaceAll(RegExp(r'\[|\]'), '')}")
        ],
      ),
    );
  }
}
