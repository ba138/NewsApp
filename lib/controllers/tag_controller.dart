import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TagController extends GetxController {
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
  var url =
      "https://newsapi.org/v2/top-headlines?category=business&apiKey=27d8f52545e2483a930414e1ecf3260e";
  void updateSelectedTag(String tag) {
    selectedTag.value = tag;
    debugPrint("Selected Tag: ${selectedTag.value}");
  }
}
