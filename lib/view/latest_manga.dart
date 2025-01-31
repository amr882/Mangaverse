import 'package:flutter/material.dart';
import 'package:mangaverse/main.dart';
import 'package:mangaverse/model/manga_model.dart';
import 'package:mangaverse/services/manga_api.dart';

class LatestMangaPage extends StatefulWidget {
  const LatestMangaPage({super.key});

  @override
  State<LatestMangaPage> createState() => _LatestMangaState();
}

class _LatestMangaState extends State<LatestMangaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: latestManga.length,
          itemBuilder: (context, index) {
            return Text(latestManga[index].id);
          }),
    );
  }
}
