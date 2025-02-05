import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangaverse/model/chapter_model.dart';
import 'package:mangaverse/model/manga_model.dart';
import 'package:mangaverse/services/manga_api.dart';
import 'package:sizer/sizer.dart';

class ChaptersPage extends StatefulWidget {
  final MangaModel mangaModel;
  const ChaptersPage({super.key, required this.mangaModel});

  @override
  State<ChaptersPage> createState() => _ChaptersPageState();
}

class _ChaptersPageState extends State<ChaptersPage> {
  List<ChapterModel> chapters = [];
  bool isLoading = true;
  Future getChapters() async {
    final req = await MangaApi.fetchChapters(widget.mangaModel.id);
    if (mounted) {
      setState(() {
        chapters = req;
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    getChapters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffafafa),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: chapters.length,
              itemBuilder: (context, index) {
                String titel = chapters[index]
                    .chapter_titel
                    .toLowerCase()
                    .split(" ")
                    .join(" :  ");
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
                          titel.length <= 20
                              ? titel
                              : "${titel.substring(0, 20)}...",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: GoogleFonts.rubik(
                              fontWeight: FontWeight.w400,
                              fontSize: 2.h,
                              color: Color(0xff323232)),
                        ),
                        Icon(
                          Icons.visibility,
                          color: Colors.grey[600],
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
