import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:newapp/controllers/news_controller.dart';

class HeadlineScreen extends StatelessWidget {
  const HeadlineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var contoller = Get.put(NewsController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Headlines"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              contoller.getNews();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(
          () => ListView.builder(
            itemBuilder: (context, index) {
              if (contoller.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(color: Colors.black),
                );
              } else if (contoller.news.isEmpty) {
                return const Center(child: Text("No News Found!"));
              } else {
                return Container(
                  margin: const EdgeInsets.all(10),
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black.withValues(alpha: 0.4),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            contoller.news[index].urlToImage ?? '',
                            fit: BoxFit.cover,
                            height: 150,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              contoller.news[index].title.length > 20
                                  ? "${contoller.news[index].title.substring(0, 20)}..."
                                  : contoller.news[index].title,
                            ),
                            Text(contoller.news[index].publishedAt),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
            itemCount: contoller.news.length,
          ),
        ),
      ),
    );
  }
}
