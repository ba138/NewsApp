import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newapp/constants/key.dart';
import 'package:http/http.dart' as http;
import 'package:newapp/models/news_model.dart';

class NewsController extends GetxController {
  var news = <Article>[].obs;
  var isLoading = false.obs;
  Future<void> getNews() async {
    isLoading.value = true;

    try {
      var uri = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey",
      );
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        debugPrint("News fetched successfully");
        debugPrint("Response: ${response.body}");
        final jsonResponse = jsonDecode(response.body);
        final newsResponse = NewsResponse.fromJson(jsonResponse);
        news.value = newsResponse.articles;
        isLoading.value = false;
      } else {
        isLoading.value = false;
        debugPrint("Failed to load news: ${response.statusCode}");
      }
    } catch (e) {
      isLoading.value = true;

      debugPrint(e.toString());
    }
  }

  @override
  void onInit() {
    getNews();
    super.onInit();
  }
}
