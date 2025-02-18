import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mangaverse/auth/keys/keys.dart';
import 'package:mangaverse/model/chapter_data_model.dart';
import 'package:mangaverse/model/chapter_model.dart';
import 'package:mangaverse/model/manga_model.dart';

class MangaApi {
  static String url = "https://mangaverse-api.p.rapidapi.com/manga/";
  static Map<String, String>? headers = {
    // apy key from rapid api   https://rapidapi.com/sagararofie/api/mangaverse-api
    "x-rapidapi-key": api_Key,
    "x-rapidapi-host": "mangaverse-api.p.rapidapi.com"
  };

  static Future<List<MangaModel>> fetchMangas(String endpoint,
      {int? page, String? text}) async {
    final Uri uri = Uri.parse(url + endpoint);
    final Map<String, String> queryParams = {};
    if (page != null) {
      queryParams['page'] = page.toString();
    }
    if (text != null) {
      queryParams['text'] = text;
    }

    final Uri finalUri = uri.replace(queryParameters: queryParams);

    final response = await http.get(finalUri, headers: headers);

    if (response.statusCode == 200) {
      final dynamic jsonData = jsonDecode(response.body);

      if (jsonData is Map<String, dynamic> &&
          jsonData.containsKey('data') &&
          jsonData['data'] is List) {
        final List<dynamic> mangaData = jsonData['data'];
        return mangaData.map((data) => MangaModel.fromJson(data)).toList();
      } else {
        throw Exception("Invalid API response format");
      }
    } else {
      throw Exception("Error getting manga data");
    }
  }

// chapter List
  static Future<List<ChapterModel>> fetchChapters(String mangaId) async {
    try {
      final response = await http.get(Uri.parse("${url}chapter?id=$mangaId"),
          headers: headers);
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body)["data"];
        return jsonData.map((data) => ChapterModel.fromJson(data)).toList();
      } else {
        throw Exception("Invalid API response format");
      }
    } on Exception {
      throw Exception("error getting chapters");
    }
  }

  static Future<List<ChapterDataModel>> fetchChaptersData(
      String chapter_id) async {
    try {
      final response = await http.get(Uri.parse("${url}image?id=$chapter_id"),
          headers: headers);
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body)["data"];
        return jsonData.map((data) => ChapterDataModel.fromJson(data)).toList();
      } else {
        throw Exception("Invalid API response format");
      }
    } on Exception {
      throw Exception("error getting chapters");
    }
  }

  static Future<List<MangaModel>> fetchLatestMangas(int page) =>
      fetchMangas("latest", page: page);

  static Future<List<MangaModel>> fetchAllMangas(int page) =>
      fetchMangas("fetch", page: page);

  static Future<List<MangaModel>> searchMangas(String mangaName) =>
      fetchMangas("search", text: mangaName);
}
