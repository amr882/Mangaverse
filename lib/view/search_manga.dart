import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangaverse/services/manga_api.dart';
import 'package:mangaverse/view/manga_details.dart';
import 'package:sizer/sizer.dart';

class SearchManga extends StatefulWidget {
  const SearchManga({super.key});

  @override
  State<SearchManga> createState() => _SearchMangaState();
}

class _SearchMangaState extends State<SearchManga> {
  final TextEditingController _controller = TextEditingController();
  List foundMangas = [];
  bool isLoading = false;
  Future searchMangas() async {
    setState(() {
      isLoading = true;
      foundMangas.clear();
    });

    try {
      final req = await MangaApi.searchMangas(_controller.text);
      setState(() {
        foundMangas.addAll(req);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      print('Error searching mangas: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Column(
        children: [
          SizedBox(
            height: 6.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: TextField(
              controller: _controller,
              style: GoogleFonts.rubik(color: Colors.white),
              cursorColor: Colors.black,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Search for manga...",
                hintStyle: TextStyle(
                  color: const Color.fromARGB(118, 0, 0, 0),
                ),
                filled: true,
                fillColor: Colors.grey[300],
                suffixIcon: Icon(
                  Icons.search_rounded,
                  color: Colors.white,
                ),
                enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.transparent)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.transparent)),
              ),
              onSubmitted: (val) {
                searchMangas();
              },
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.085.h,
                    ),
                    itemCount: foundMangas.length,
                    itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MangaDetails(
                                    mangaModel: foundMangas[index])));
                          },
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(13),
                                child: Image.network(
                                  foundMangas[index].manga_photo,
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
    );
  }
}
