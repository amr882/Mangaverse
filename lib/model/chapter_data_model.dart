class ChapterDataModel {
  String manga_id;
  String chapter_id;
  String chpterData_id;
  String image_data;
  ChapterDataModel(
      {required this.chapter_id,
      required this.chpterData_id,
      required this.image_data,
      required this.manga_id});
  factory ChapterDataModel.fromJson(Map<String, dynamic> json) {
    return ChapterDataModel(
        chapter_id: json["chapter"],
        chpterData_id: json["id"],
        image_data: json["link"],
        manga_id: json["manga"]);
  }
}
