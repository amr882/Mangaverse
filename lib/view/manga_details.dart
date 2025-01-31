import 'package:flutter/material.dart';
import 'package:mangaverse/model/manga_model.dart';

class MangaDetails extends StatefulWidget {
  final MangaModel mangaModel;
  const MangaDetails({super.key, required this.mangaModel});

  @override
  State<MangaDetails> createState() => _MangaDetailsState();
}

class _MangaDetailsState extends State<MangaDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.mangaModel.manga_titel),
      ),
    );
  }
}
