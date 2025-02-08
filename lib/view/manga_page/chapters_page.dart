import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangaverse/model/chapter_model.dart';
import 'package:mangaverse/model/manga_model.dart';
import 'package:sizer/sizer.dart';

class ChaptersPage extends StatefulWidget {
  final MangaModel mangaModel;
  final List<ChapterModel> allChapters;
  const ChaptersPage(
      {super.key, required this.mangaModel, required this.allChapters});

  @override
  State<ChaptersPage> createState() => _ChaptersPageState();
}

class _ChaptersPageState extends State<ChaptersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffafafa),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: widget.allChapters.length,
        itemBuilder: (context, index) {
          String titel = widget.allChapters[index].chapter_titel
              .toLowerCase()
              .split(" ")
              .join(" : ");
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              width: 90.w,
              height: 5.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    titel.length <= 20 ? titel : "${titel.substring(0, 20)}...",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: GoogleFonts.rubik(
                        fontWeight: FontWeight.w500,
                        fontSize: 1.5.h,
                        color: Color(0xff182128)),
                  ),
                  Icon(
                    Icons.visibility,
                    color: Color(0xffbdc1c2),
                    size: 2.5.h,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
