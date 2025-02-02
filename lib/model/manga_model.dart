class MangaModel {
  final String id;
  final String manga_photo;
  final String manga_titel;
  final String status;
  final String sub_title;
  final String summary;
  final List<dynamic> authors;
  final List<dynamic> genres;
  final int total_chapter;
  final int create_at;

  MangaModel({
    required this.create_at,
    required this.id,
    required this.manga_photo,
    required this.manga_titel,
    required this.status,
    required this.sub_title,
    required this.summary,
    required this.authors,
    required this.genres,
    required this.total_chapter,
  });

  factory MangaModel.fromJson(Map<String, dynamic> json) {
    return MangaModel(
        id: json["id"],
        manga_photo: json["thumb"],
        manga_titel: json["title"],
        status: json["status"],
        sub_title: json["sub_title"],
        summary: json["summary"],
        authors: json["authors"] as List<dynamic>,
        genres: json["genres"] as List<dynamic>,
        total_chapter: json["total_chapter"],
        create_at: json["create_at"]
        );
  }
}
