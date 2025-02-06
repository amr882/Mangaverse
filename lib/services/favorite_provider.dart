import 'package:flutter/material.dart';
import 'package:mangaverse/model/manga_model.dart';
import 'package:provider/provider.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<MangaModel> _favoriteProvider = [];
  List<MangaModel> get favorites => _favoriteProvider;

  void toggleFavorite(MangaModel mangaModel) {
    if (_favoriteProvider.contains(mangaModel)) {
      _favoriteProvider.remove(mangaModel);
    } else {
      _favoriteProvider.add(mangaModel);
    }

    notifyListeners();
  }

  bool isExist(MangaModel mangaModel) {
    final isExist = _favoriteProvider.contains(mangaModel);
    return isExist;
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
