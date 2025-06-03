import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;

class UploadNewsController extends GetxController {
  var isLoading = false.obs;
  Future<void> uploadNews(
    String title,
    String discription,
    DateTime datetime,
    String newsId,
  ) async {
    try {
      isLoading.value = true;
      var data = {
        title: title,
        discription: discription,
        datetime: datetime.toIso8601String(),
      };
      var uri = Uri.parse('https://newsapi.org/v2/everything?api');
      var response = await http.post(uri, body: data);
      if (response.statusCode == 200) {
        debugPrint("News uploaded successfully");
      } else {
        debugPrint("Failed to upload news: ${response.statusCode}");
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      debugPrint("Error uploading news: $e");
    }
  }

  Future<void> deleteNews(String newsId) async {
    try {
      var uri = Uri.parse("https://newsapi.org/v2/everything?api");
      var response = await http.delete(uri, body: {"newsId": newsId});
      if (response.statusCode == 200) {
        debugPrint("News deleted successfully");
      } else {
        debugPrint("Failed to delete news: ${response.body}");
      }
    } catch (e) {
      debugPrint("Error deleting news: $e");
    }
  }

  Future<void> updateNews(
    String newsId,
    String title,
    String discription,
    DateTime datetime,
  ) async {
    try {
      var uri = Uri.parse("https://newsapi.org/v2/everything?api");
      var data = {
        "newsId": newsId,
        "title": title,
        "discription": discription,
        "datetime": datetime.toIso8601String(),
      };
      var response = await http.put(uri, body: data);
      if (response.statusCode == 200) {
        debugPrint("News updated successfully");
      } else {
        debugPrint("Failed to update news: ${response.body}");
      }
    } catch (e) {
      debugPrint("Error updating news: $e");
    }
  }
}
