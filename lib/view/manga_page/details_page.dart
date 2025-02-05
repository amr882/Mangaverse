import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mangaverse/model/manga_model.dart';
import 'package:mangaverse/widgets/manga_details_card.dart';
import 'package:sizer/sizer.dart';

class DetailsPage extends StatefulWidget {
  final MangaModel mangaModel;
  const DetailsPage({
    super.key,
    required this.mangaModel,
  });

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  String time = "";
  getTime() {
    var dateUtc = DateTime.fromMillisecondsSinceEpoch(
        widget.mangaModel.create_at,
        isUtc: true);
    var dateInMyTimezone = dateUtc.add(Duration(hours: 8));
    var month = DateFormat('MMMM').format(DateTime(0, dateInMyTimezone.month));
    setState(() {
      time = "${dateInMyTimezone.year},$month,${dateInMyTimezone.day}";
    });
  }

  @override
  void initState() {
    getTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffafafa),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: 100.w,
                  height: 35.h,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(200, 255, 255, 255),
                          spreadRadius: 50,
                          blurRadius: 20,
                          offset: Offset(0, 3)),
                    ],
                  ),
                  child: CachedNetworkImage(
                    imageUrl: widget.mangaModel.manga_photo,
                    placeholder: (context, url) => SizedBox(
                        height: 5.h,
                        child: Center(child: CircularProgressIndicator())),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: 100.w,
                  height: 36.h,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        Color.fromARGB(160, 255, 255, 255),
                        Colors.white
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(2.h),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: widget.mangaModel.manga_photo,
                          placeholder: (context, url) => SizedBox(
                              height: 5.h,
                              child:
                                  Center(child: CircularProgressIndicator())),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          height: 27.5.h,
                          width: 35.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Column(
                        children: [
                          SizedBox(
                              width: 50.w,
                              child: Text(
                                widget.mangaModel.manga_titel,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          SizedBox(
                              width: 50.w,
                              child: Text(
                                widget.mangaModel.status,
                                style: TextStyle(
                                    color: Color.fromARGB(255, 110, 110, 109)),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            MangaDetailsCard(
                manga_photo: widget.mangaModel.manga_photo,
                manga_titel: widget.mangaModel.manga_titel,
                status: widget.mangaModel.status,
                create_at: widget.mangaModel.create_at,
                summary: widget.mangaModel.summary,
                genres: widget.mangaModel.genres,
                total_chapter: widget.mangaModel.total_chapter,
                authors: widget.mangaModel.authors,
                time: time)
          ],
        ),
      ),
    );
  }
}
