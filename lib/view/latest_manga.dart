import 'package:flutter/material.dart';
import 'package:mangaverse/model/manga_model.dart';
import 'package:mangaverse/services/manga_api.dart';
import 'package:mangaverse/view/manga_details.dart';
import 'package:sizer/sizer.dart';

class LatestMangaPage extends StatefulWidget {
  const LatestMangaPage({super.key});

  @override
  State<LatestMangaPage> createState() => _LatestMangaState();
}

class _LatestMangaState extends State<LatestMangaPage> {
  List<MangaModel> latestManga = [];
  int currentPage = 1;
  bool isLoading = true;
  Future featchLatestMangas() async {
    isLoading = true;
    final req = await MangaApi.featchLatestMangas(currentPage);
    if (mounted) {
      setState(() {
        latestManga.addAll(req);
        currentPage++;
        isLoading = false;
      });
    }
    print(latestManga);
  }

  @override
  void initState() {
    featchLatestMangas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification.metrics.pixels ==
                        notification.metrics.maxScrollExtent &&
                    notification is ScrollUpdateNotification &&
                    !isLoading) {
                  featchLatestMangas();
                }
                return true;
              },
              child: Column(
                children: [
                   SizedBox(
                    height: 4.h,
                  ),
                  Expanded(
                    child: GridView.builder(
                        physics: BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.085.h,
                        ),
                        itemCount: latestManga.length,
                        itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => MangaDetails(
                                        mangaModel: latestManga[index])));
                              },
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(13),
                                    child: Image.network(
                                      latestManga[index].manga_photo,
                                      height: 22.5.h,
                                      width: 30.w,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                  ),
                ],
              ),
            ),
    );
  }
}
