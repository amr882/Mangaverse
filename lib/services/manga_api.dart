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
    final respone = await http.get(
        Uri.parse("${url}manga/latest?page=$current_page&type=all"),
        headers: headers);

    if (respone.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(respone.body)["data"];
      final List<MangaModel> mangas =
          jsonData.map((data) => MangaModel.fromJson(data)).toList();
      return mangas;
    } else {
      throw Exception("error getting manga data");
    }
  }

  // featch all mangas
  static Future fetchAllMangas(int current_page) async {
    final respone = await http.get(
        Uri.parse("${url}manga/fetch?page=$current_page&type=all"),
        headers: headers);

    if (respone.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(respone.body)["data"];
      final List<MangaModel> mangas =
          jsonData.map((data) => MangaModel.fromJson(data)).toList();
      return mangas;
    } else {
      throw Exception("error getting manga data");
    }
  }

  // search for mangas
  static Future searchMangas(String mangaName) async {
    final respone = await http
        .get(Uri.parse("${url}manga/search?text=$mangaName"), headers: headers);
    if (respone.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(respone.body)["data"];
      final List<MangaModel> mangas =
          jsonData.map((data) => MangaModel.fromJson(data)).toList();
      return mangas;
    } else {
      throw Exception("error getting data");
    }
  }

  //get manga (manga id)
  // manga?id=659524dd597f3b00281f06ff

  static Future getManga(String manga_id) async {
    final respone =
        await http.get(Uri.parse("${url}manga?id=$manga_id"), headers: headers);
    if (respone.statusCode == 200) {
      return MangaModel.fromJson(jsonDecode(respone.body)["data"]);
    } else {
      throw Exception("error getting data");
    }
  }
}
