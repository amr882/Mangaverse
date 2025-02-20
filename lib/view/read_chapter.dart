import 'package:cached_network_image/cached_network_image.dart';
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
  Future<List<ChapterDataModel>> getData() async {
    var data = await MangaApi.fetchChaptersData(widget.chapterModel.chapter_id);
    return data;
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<ChapterDataModel>>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return CachedNetworkImage(
                  imageUrl: snapshot.data![index].image_data,
                  fit: BoxFit.contain,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fadeInDuration: const Duration(milliseconds: 300),
                );
              },
            );
          }
        },
      ),
    );
  }
}
