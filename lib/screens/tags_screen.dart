import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newapp/controllers/tag_controller.dart';

class TagsScreen extends StatelessWidget {
  const TagsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(TagController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tags"),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 60,
            width: MediaQuery.of(context).size.width,
            child: Obx(() {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: controller.tags.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  var category = controller.tags[index];
                  return InkWell(
                    onTap: () {
                      controller.getTags(category);
                      // controller.updateSelectedTag(category);
                      // debugPrint(
                      //   "Selected Tag: ${controller.selectedTag.value}",
                      // );
                    },
                    child: Obx(
                      () => Container(
                        margin: const EdgeInsets.all(10),
                        height: 50,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:
                              controller.selectedTag.value ==
                                      controller.tags[index]
                                  ? Colors.blueGrey
                                  : Colors.grey,
                        ),
                        child: Center(
                          child: Text(
                            category,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          Obx(() {
            if (controller.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            } else if (controller.tagNews.isEmpty) {
              return Text("No News available");
            }
            return Expanded(
              child: ListView.builder(
                itemCount: controller.tagNews.length,
                itemBuilder: (context, index) {
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
                              controller.tagNews[index].urlToImage ?? '',
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
                                controller.tagNews[index].title.length > 20
                                    ? "${controller.tagNews[index].title.substring(0, 20)}..."
                                    : controller.tagNews[index].title,
                              ),
                              Text(controller.tagNews[index].publishedAt),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
