import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:newapp/constants/key.dart';
import 'package:newapp/models/news_model.dart';

class TagController extends GetxController {
  var isLoading = false.obs;
  var tagNews = <Article>[].obs;
  var tags =
      [
        "all categories",
        "business",
        "entertainment",
        "general",
        "health",
        "science",
        "sports",
        "technology",
      ].obs;
  var selectedTag = "all categories".obs;

  void updateSelectedTag(String tag) {
    selectedTag.value = tag;
    debugPrint("Selected Tag: ${selectedTag.value}");
  }

  Future<void> getTags(String tag) async {
    try {
      isLoading.value = true;
      selectedTag.value = tag;
      var url =
          "https://newsapi.org/v2/top-headlines?category=$tag&apiKey=$apiKey";
      var uri = Uri.parse(url);
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        final jasonResponse = jsonDecode(response.body);
        debugPrint("this is the response of the tags:$jasonResponse");
        final newsResponse = NewsResponse.fromJson(jasonResponse);
        tagNews.value = newsResponse.articles;
        isLoading.value = false;
      } else {
        isLoading.value = false;

        debugPrint("this is the response ${response.body}");
      }
    } catch (e) {
      isLoading.value = false;

      debugPrint("this is the error $e");
    }
  }

  @override
  void onInit() {
    getTags("all categories");
    super.onInit();
  }
}
