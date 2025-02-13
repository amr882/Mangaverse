import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mangaverse/model/manga_model.dart';
import 'package:provider/provider.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<MangaModel> _favoriteProvider = [];
  List<MangaModel> get favorites => _favoriteProvider;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FavoriteProvider() {
    _loadFavorites();
  }

  bool isExist(MangaModel mangaModel) {
    return _favoriteProvider.contains(mangaModel);
  }

// to load fav from firestore and show it in manga page if it is in fav or not
  Future<void> _loadFavorites() async {
    if (_auth.currentUser == null) return;
    final userId = _auth.currentUser!.uid;

    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('favorites')
          .get();

      _favoriteProvider.clear();
      for (final doc in snapshot.docs) {
        final manga = MangaModel.fromJson(doc.data());
        _favoriteProvider.add(manga);
      }
      notifyListeners();
    } catch (e) {
      print("Error loading favorites: $e");
    }
  }

  void toggleFavorite(MangaModel mangaModel) async {
    final userId = _auth.currentUser!.uid;
    final mangaId = mangaModel.id;

    if (_favoriteProvider.contains(mangaModel)) {
      _favoriteProvider.remove(mangaModel);
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('favorites')
          .doc(mangaId)
          .delete();
    } else {
      _favoriteProvider.add(mangaModel);
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('favorites')
          .doc(mangaModel.id)
          .set(mangaModel.toJson());
    }

    notifyListeners();
  }

  static FavoriteProvider of(
    BuildContext context, {
    bool listen = true,
  }) {
    return Provider.of<FavoriteProvider>(
      context,
      listen: listen,
    );
  }
}
