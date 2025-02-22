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

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  FavoriteProvider() {
    _loadFavorites();
  }

  bool isExist(MangaModel mangaModel) {
    return _favoriteProvider.any((element) => element.id == mangaModel.id);
  }

  Future<void> _loadFavorites() async {
    _isLoading = true;
    notifyListeners();

    if (_auth.currentUser == null) {
      _isLoading = false;
      notifyListeners();
      return;
    }
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
    }
    _isLoading = false;
    notifyListeners();
  }

  void toggleFavorite(MangaModel mangaModel) async {
    final userId = _auth.currentUser!.uid;
    final mangaId = mangaModel.id;

    if (_favoriteProvider.any((element) => element.id == mangaId)) {
      _favoriteProvider.removeWhere((element) => element.id == mangaId);
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
