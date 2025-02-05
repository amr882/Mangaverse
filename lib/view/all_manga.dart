import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mangaverse/model/manga_model.dart';
import 'package:mangaverse/services/manga_api.dart';
import 'package:mangaverse/view/manga_details.dart';
import 'package:sizer/sizer.dart';

class AllManga extends StatefulWidget {
  const AllManga({super.key});

  @override
  State<AllManga> createState() => _AllMangaState();
}

class _AllMangaState extends State<AllManga> {
  List<MangaModel> allManga = [];
  int currentPage = 1;
  bool isLoading = true;
  Future fetchAllMangas() async {
    isLoading = true;
    final req = await MangaApi.fetchAllMangas(currentPage);
    if (mounted) {
      setState(() {
        allManga.addAll(req);
        currentPage++;
        isLoading = false;
      });
    }
    print(allManga);
  }

  @override
  void initState() {
    fetchAllMangas();
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
                  fetchAllMangas();
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
                        itemCount: allManga.length,
                        itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => MangaDetails(
                                        mangaModel: allManga[index])));
                              },
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(13),
                                    child: CachedNetworkImage(
                                      imageUrl: allManga[index].manga_photo,
                                      placeholder: (context, url) => Container(
                                          height: 22.5.h,
                                          width: 30.w,
                                          color: Colors.white,
                                          child: Center()),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
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
