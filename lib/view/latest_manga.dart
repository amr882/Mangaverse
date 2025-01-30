import 'package:flutter/material.dart';
import 'package:mangaverse/model/manga_model.dart';
import 'package:mangaverse/services/manga_api.dart';

class LatestManga extends StatefulWidget {
  const LatestManga({super.key});

  @override
  State<LatestManga> createState() => _LatestMangaState();
}

class _LatestMangaState extends State<LatestManga> {
  List<MangaModel> manga = [];
  Future fetchMangas() async {
    final req = await MangaApi.fetchMangas(1);
    setState(() {
      manga = req;
    });
    print(manga);
  }

  @override
  void initState() {
    // fetchMangas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: manga.length,
          itemBuilder: (context, index) {
            return Text(manga[index].id);
          }),
    );
  }
}
