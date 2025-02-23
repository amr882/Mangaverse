import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mangaverse/services/favorite_provider.dart';
import 'package:mangaverse/view/manga_details.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteProvider>(
      builder: (context, value, child) {
        return GridView.builder(
            physics: BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.085.h,
            ),
            itemCount: value.favorites.length,
            itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            MangaDetails(mangaModel: value.favorites[index])));
                  },
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(13),
                        child: CachedNetworkImage(
                          imageUrl: value.favorites[index].manga_photo,
                          placeholder: (context, url) => Container(
                            height: 22.5.h,
                            width: 30.w,
                            color: Colors.white,
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          height: 22.5.h,
                          width: 30.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ));
      },
    );
  }
}
