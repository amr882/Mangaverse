class ChapterModel {
  String manga_id;
  String chapter_id;

  ChapterModel({
    required this.chapter_id,
    required this.manga_id,
  });

  factory ChapterModel.fromJson(Map<String, dynamic> json) {
    return ChapterModel(
      chapter_id: json["id"],
      manga_id: json["manga"],
    );
  }
}
