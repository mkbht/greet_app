import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greet_app/controllers/story_controller.dart';
import 'package:greet_app/models/Story.dart';
import 'package:stories_for_flutter/stories_for_flutter.dart';

class StoryList extends StatelessWidget {
  const StoryList({super.key});

  @override
  Widget build(BuildContext context) {
    StoryController storyController = Get.find<StoryController>();
    storyController.fetchStories();

    var stories = storyController.stories;
    print(stories);

    return Stories(
      displayProgress: true,
      highLightColor: Colors.grey,
      storyItemList: () {
        List<StoryItem> storyItems = [];
        stories.forEach((story) {
          storyItems.add(StoryItem(
            name: story.user!.username ?? "",
            thumbnail: NetworkImage(story.user!.avatar ?? ''),
            stories: [
              Scaffold(
                backgroundColor: Colors.blue,
                body: Center(
                  child: Text(
                    story.text ?? "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ],
          ));
        });
        return storyItems;
      }(),
    );
  }
}
