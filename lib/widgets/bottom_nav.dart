import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:mangaverse/view/all_manga.dart';
import 'package:mangaverse/view/latest_manga.dart';
import 'package:mangaverse/view/search_manga.dart';
import 'package:mangaverse/view/user_profile.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  var _currentPage = 0;
  List<Widget> pages = [
    const LatestManga(),
    const AllManga(),
    const SearchManga(),
    const UserProfile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      bottomNavigationBar: Container(
        color: const Color(0xffffffff),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SalomonBottomBar(
            backgroundColor: const Color(0xffffffff),
            currentIndex: _currentPage,
            onTap: (value) {
              setState(() {
                _currentPage = value;
              });
            },
            items: [
              /// Latest
              SalomonBottomBarItem(
                icon: const HugeIcon(
                  icon: HugeIcons.strokeRoundedSparkles,
                  color: Colors.green,
                ),
                title: const Text("Latest"),
                selectedColor: Colors.teal,
              ),

              /// All manga
              SalomonBottomBarItem(
                icon: const Icon(
                  Icons.menu_book_rounded,
                  color: Colors.green,
                ),
                title: const Text("All manga"),
                selectedColor: Colors.teal,
              ),

              /// Search
              SalomonBottomBarItem(
                icon: const Icon(
                  Icons.search,
                  color: Colors.green,
                ),
                title: const Text("Search"),
                selectedColor: Colors.teal,
              ),

              /// Profile
              SalomonBottomBarItem(
                icon: const Icon(
                  Icons.person,
                  color: Colors.green,
                ),
                title: const Text("Profile"),
                selectedColor: Colors.teal,
              ),
            ],
          ),
        ),
      ),
      body: pages[_currentPage]
    );
  }
}