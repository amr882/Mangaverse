import 'package:flutter/material.dart';
import 'package:mangaverse/model/chapter_data_model.dart';
import 'package:mangaverse/model/chapter_model.dart';
import 'package:mangaverse/services/manga_api.dart';

class ReadChapter extends StatefulWidget {
  final ChapterModel chapterModel;
  const ReadChapter({super.key, required this.chapterModel});

  @override
  State<ReadChapter> createState() => _ReadChapterState();
}

class _ReadChapterState extends State<ReadChapter> {
  List<ChapterDataModel> chapter_data = [];
  Future getData() async {
    final req =
        await MangaApi.fetchChaptersData(widget.chapterModel.chapter_id);
    setState(() {
      chapter_data = req;
    });
    print(chapter_data[0].image_data);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: chapter_data.length,
        itemBuilder: (context, index) {
          return Image.network(chapter_data[index].image_data);
        },
      ),
    );
  }
}
