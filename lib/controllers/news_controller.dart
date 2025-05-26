import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newapp/constants/key.dart';
import 'package:http/http.dart' as http;
import 'package:newapp/models/news_model.dart';

class NewsController extends GetxController {
  var news = <Article>[].obs;
  void getNews() {
    try {
      var uri = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey",
      );
      final response = http.get(uri);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final newsResponse = NewsResponse.fromJson(jsonResponse);
        news.value = newsResponse.articles;
      } else {
        debugPrint("Failed to load news: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
