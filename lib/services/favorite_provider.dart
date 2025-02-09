import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mangaverse/model/manga_model.dart';
import 'package:provider/provider.dart';

// class FavoriteProvider extends ChangeNotifier {
//   final List<MangaModel> _favoriteProvider = [];
//   List<MangaModel> get favorites => _favoriteProvider;

//   void toggleFavorite(MangaModel mangaModel) {
//     if (_favoriteProvider.contains(mangaModel)) {
//       _favoriteProvider.remove(mangaModel);
//     } else {
//       _favoriteProvider.add(mangaModel);
//     }

//     notifyListeners();
//   }

//   bool isExist(MangaModel mangaModel) {
//     final isExist = _favoriteProvider.contains(mangaModel);
//     return isExist;
//   }

//   static FavoriteProvider of(
//     BuildContext context, {
//     bool listen = true,
//   }) {
//     return Provider.of<FavoriteProvider>(
//       context,
//       listen: listen,
//     );
//   }
// }

class FavoriteProvider extends ChangeNotifier {
  final List<MangaModel> _favoriteProvider = [];
  List<MangaModel> get favorites => _favoriteProvider;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FavoriteProvider() {
    _loadFavorites(); // Load favorites from Firestore on initialization
  }

  Future<void> _loadFavorites() async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot doc =
            await _firestore.collection('users').doc(user.uid).get();

        if (doc.exists) {
          List<dynamic> favoriteIds = doc.get('favorites') ?? [];
          _favoriteProvider.clear(); // Clear existing favorites

          for (var mangaId in favoriteIds) {
            // Fetch manga details based on ID and add to favorites
            DocumentSnapshot mangaDoc = await _firestore
                .collection('mangas') // Assuming you have a 'mangas' collection
                .doc(mangaId)
                .get();

            if (mangaDoc.exists) {
              MangaModel manga =
                  MangaModel.fromJson(mangaDoc.data() as Map<String, dynamic>);
              _favoriteProvider.add(manga);
            }
          }
        }
        notifyListeners();
      } catch (e) {
        print('Error loading favorites: $e');
        // Handle error, e.g., show a snackbar
      }
    }
  }

  Future<void> toggleFavorite(MangaModel mangaModel) async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        DocumentReference userDoc =
            _firestore.collection('users').doc(user.uid);
        List<String> favoriteIds = [];
        DocumentSnapshot doc = await userDoc.get();
        if (doc.exists) {
          favoriteIds = List<String>.from(doc.get('favorites') ?? []);
        }

        if (favoriteIds.contains(mangaModel.id)) {
          favoriteIds.remove(mangaModel.id);
          _favoriteProvider.removeWhere((item) => item.id == mangaModel.id);
        } else {
          favoriteIds.add(mangaModel.id);
          _favoriteProvider.add(mangaModel);
        }

        await userDoc.set({'favorites': favoriteIds},
            SetOptions(merge: true)); // Update Firestore
        notifyListeners();
      } catch (e) {
        print('Error toggling favorite: $e');
        // Handle error
      }
    }
  }

  bool isExist(MangaModel mangaModel) {
    return _favoriteProvider.any((item) => item.id == mangaModel.id);
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
