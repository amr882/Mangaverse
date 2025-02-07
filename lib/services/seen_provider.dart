import 'package:flutter/material.dart';
import 'package:mangaverse/model/chapter_model.dart';
import 'package:provider/provider.dart';

class SeenPeovider extends ChangeNotifier {
  final List<ChapterModel> _seenProvider = [];
  List<ChapterModel> get seen => _seenProvider;

  void toggleSeen(ChapterModel chapterModel) {
    if (_seenProvider.contains(chapterModel)) {
      _seenProvider.remove(chapterModel);
    } else {
      _seenProvider.add(chapterModel);
    }

    notifyListeners();
  }

  bool viewed(ChapterModel chapterModel) {
    final viewed = _seenProvider.contains(chapterModel);
    return viewed;
  }

  static SeenPeovider of(
    BuildContext context, {
    bool listen = true,
  }) {
    return Provider.of<SeenPeovider>(
      context,
      listen: listen,
    );
  }
}
