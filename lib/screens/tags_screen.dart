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
                      controller.updateSelectedTag(category);
                      debugPrint(
                        "Selected Tag: ${controller.selectedTag.value}",
                      );
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
        ],
      ),
    );
  }
}
