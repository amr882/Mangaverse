import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mangaverse/model/manga_model.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final List<MangaModel> _favoriteProvider = [];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> loadFavorites() async {
    if (_auth.currentUser == null) return;
    final userId = _auth.currentUser!.uid;

    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .get();

    _favoriteProvider.clear();

    for (final doc in snapshot.docs) {
      final manga = MangaModel.fromJson(doc.data());
      _favoriteProvider.add(manga);
      print(_favoriteProvider[0].id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: MaterialButton(
        onPressed: () {
          loadFavorites();
        },
        color: Colors.red,
        child: Text("sign out"),
      )),
    );
  }
}
