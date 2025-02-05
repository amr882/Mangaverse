class ChapterModel {
  final String manga_id;
  final String chapter_id;
  final String chapter_titel;

  ChapterModel({
    required this.manga_id,
    required this.chapter_id,
    required this.chapter_titel,
  });

  factory ChapterModel.fromJson(Map<String, dynamic> json) {
    return ChapterModel(
      manga_id: json["manga"],
      chapter_id: json["id"],
      chapter_titel: json["title"],
    );
  }
}
