import 'package:flutter/material.dart';
import 'package:mangaverse/model/manga_model.dart';
import 'package:mangaverse/view/manga_page/chapters_page.dart';
import 'package:mangaverse/view/manga_page/details_page.dart';
import 'package:mangaverse/view/manga_page/more_like_this_page.dart';
import 'package:sizer/sizer.dart';

class MangaDetails extends StatefulWidget {
  final MangaModel mangaModel;
  const MangaDetails({super.key, required this.mangaModel});

  @override
  State<MangaDetails> createState() => _MangaDetailsState();
}

class _MangaDetailsState extends State<MangaDetails> {
  GlobalKey<ScaffoldState> globalKey = GlobalKey();
  bool isFav = false;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            key: globalKey,
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              elevation: 5,
              shadowColor: Theme.of(context).colorScheme.shadow,
              title: Text(
                widget.mangaModel.manga_titel.length <= 20
                    ? widget.mangaModel.manga_titel
                    : "${widget.mangaModel.manga_titel.substring(0, 20)}...",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(fontSize: 2.h),
              ),
              bottom: TabBar(
                indicatorColor: Colors.green,
                labelColor: Colors.green,
                tabs: <Widget>[
                  Tab(
                    icon: Text("Manga details"),
                  ),
                  Tab(
                    icon: Text("chapters"),
                  ),
                  Tab(
                    icon: Text("more like this"),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: isFav
                      ? Icon(
                          Icons.favorite_outlined,
                          color: Colors.red,
                        )
                      : Icon(Icons.favorite_border_rounded),
                  onPressed: () {
                    setState(() {
                      isFav = !isFav;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {},
                )
              ],
            ),
            body: TabBarView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                DetailsPage(
                  mangaModel: widget.mangaModel,
                ),
                ChaptersPage(),
                MoreLikeThisPage()
              ],
            )));
  }
}
