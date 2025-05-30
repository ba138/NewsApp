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
  void updateSelectedTag(String tag) {
    selectedTag.value = tag;
    debugPrint("Selected Tag: ${selectedTag.value}");
  }
}
