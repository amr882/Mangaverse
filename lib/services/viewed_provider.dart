import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mangaverse/model/chapter_model.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class ViewedProvider extends ChangeNotifier {
  final List<ChapterModel> _ViewedProvider = [];
  List<ChapterModel> get viewes => _ViewedProvider;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final StreamController<List<ChapterModel>> _viewedStreamController =
      StreamController<List<ChapterModel>>.broadcast();

  Stream<List<ChapterModel>> get viewedStream => _viewedStreamController.stream;

  ViewedProvider() {
    _loadViewes();
  }

  bool isExist(ChapterModel ChapterModel) {
    return _ViewedProvider.any(
        (element) => element.chapter_id == ChapterModel.chapter_id);
  }

  Future<void> _loadViewes() async {
    if (_auth.currentUser == null) return;
    final userId = _auth.currentUser!.uid;

    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('viewed')
        .get();

    _ViewedProvider.clear();
    for (final doc in snapshot.docs) {
      final chapter = ChapterModel.fromJson(doc.data());
      _ViewedProvider.add(chapter);
    }
    _viewedStreamController.add(_ViewedProvider);
    notifyListeners();
  }

  void view(ChapterModel chapterModel) async {
    final userId = _auth.currentUser!.uid;
    _ViewedProvider.add(chapterModel);
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('viewed')
        .doc(chapterModel.chapter_id)
        .set(chapterModel.toJson());
    _viewedStreamController.add(_ViewedProvider);
  }

  void toggleView(ChapterModel chapterModel) async {
    final userId = _auth.currentUser!.uid;
    final chapterId = chapterModel.chapter_id;

    if (_ViewedProvider.contains(chapterModel)) {
      _ViewedProvider.removeWhere((element) => element.chapter_id == chapterId);
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('viewed')
          .doc(chapterId)
          .delete();
    } else {
      _ViewedProvider.add(chapterModel);
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('viewed')
          .doc(chapterModel.chapter_id)
          .set(chapterModel.toJson());
    }
    _viewedStreamController.add(_ViewedProvider);
    notifyListeners();
  }

  static ViewedProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<ViewedProvider>(context, listen: listen);
  }

  @override
  void dispose() {
    _viewedStreamController.close();
    super.dispose();
  }
}
