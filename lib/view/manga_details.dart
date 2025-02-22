import 'package:flutter/material.dart';
import 'package:mangaverse/model/chapter_model.dart';
import 'package:mangaverse/model/manga_model.dart';
import 'package:mangaverse/services/favorite_provider.dart';
import 'package:mangaverse/services/manga_api.dart';
import 'package:mangaverse/view/manga_page/chapters_page.dart';
import 'package:mangaverse/view/manga_page/details_page.dart';
import 'package:mangaverse/view/manga_page/more_like_this_page.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class MangaDetails extends StatefulWidget {
  final MangaModel mangaModel;
  const MangaDetails({super.key, required this.mangaModel});

  @override
  State<MangaDetails> createState() => _MangaDetailsState();
}

class _MangaDetailsState extends State<MangaDetails> {
  GlobalKey<ScaffoldState> globalKey = GlobalKey();

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
    return Consumer<FavoriteProvider>(
      builder: (context, value, child) {
        if (value.isLoading) {
          return const Scaffold(
              body: Center(
                  child: CircularProgressIndicator(
            color: Colors.green,
          )));
        }
        return DefaultTabController(
            length: 3,
            child: Scaffold(
                key: globalKey,
                appBar: AppBar(
                  backgroundColor: const Color(0xfffafafa),
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
                      icon: value.isExist(widget.mangaModel)
                          ? const Icon(Icons.favorite_outlined,
                              color: Colors.green)
                          : const Icon(Icons.favorite_border_rounded),
                      onPressed: () async {
                        setState(() {
                          value.toggleFavorite(widget.mangaModel);
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_vert),
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
                    ChaptersPage(
                      mangaModel: widget.mangaModel,
                      allChapters: chapters,
                    ),
                    MoreLikeThisPage()
                  ],
                )));
      },
    );
  }
}
