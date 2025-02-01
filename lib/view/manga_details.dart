import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mangaverse/model/manga_model.dart';

class MangaDetails extends StatefulWidget {
  final MangaModel mangaModel;
  const MangaDetails({super.key, required this.mangaModel});

  @override
  State<MangaDetails> createState() => _MangaDetailsState();
}

class _MangaDetailsState extends State<MangaDetails> {
  GlobalKey<ScaffoldState> globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: globalKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Text("1"),
              ),
              Tab(
                icon: Text("2"),
              ),
              Tab(
                icon: Text("3"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
