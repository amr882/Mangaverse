import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mangaverse/auth/keys/keys.dart';
import 'package:mangaverse/model/manga_model.dart';

class MangaApi {
  static String url = "https://mangaverse-api.p.rapidapi.com/";
  static Map<String, String>? headers = {
    // apy key from rapid api   https://rapidapi.com/sagararofie/api/mangaverse-api
    "x-rapidapi-key": api_Key,
    "x-rapidapi-host": "mangaverse-api.p.rapidapi.com"
  };

// featch latest mangas

  static Future featchLatestMangas(int current_page) async {
    final response = await http.get(
        Uri.parse("${url}manga/latest?page=$current_page&type=all"),
        headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body)["data"];
      final List<MangaModel> mangas =
          jsonData.map((data) => MangaModel.fromJson(data)).toList();
      return mangas;
    } else {
      throw Exception("error getting manga data");
    }
  }

//  manga/latest?page=1&type=all

  // featch all mangas
  static Future fetchMangas(int current_page) async {
    final response = await http.get(
        Uri.parse("${url}manga/fetch?page=$current_page&type=all"),
        headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body)["data"];
      final List<MangaModel> mangas =
          jsonData.map((data) => MangaModel.fromJson(data)).toList();
      return mangas;
    } else {
      throw Exception("error getting manga data");
    }
  }
}
