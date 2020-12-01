import 'package:flutter/material.dart';
import 'package:green_karma/common/helper.dart';
import 'package:green_karma/models/karma.dart';

class TileData {
  Color color1;
  Color color2;
  String path;

  TileData(this.color1, this.color2, this.path) {
    if (path == null) {
      path = 'assets/images/breakfast.png';
    }
  }
}

class TaskListData {
  TaskListData({
    this.imagePath = '',
    this.titleText = '',
    this.startColor = const Color(0xFFFFFFFF),
    this.endColor = const Color(0xFFFFFFFF),
    this.taskInfo,
    this.karma = 0,
  });

  String imagePath;
  String titleText;
  Color startColor;
  Color endColor;
  String taskInfo;
  int karma;

  Map<KarmaCategory, TileData> colorsMap = {
    KarmaCategory.community_service: new TileData(Color(0xFFFA7D82), Color(0xFFFFB295), null),
    KarmaCategory.commute: new TileData(Color(0xFF738AE6), Color(0xFF5C5EDD), null),
    KarmaCategory.ecofriendly_purchase: new TileData(Color(0xFFFE95B6), Color(0xFFFF5287), 'assets/images/dinner.png'),
    KarmaCategory.electricity: new TileData(Color(0xFF6F72CA), Color(0xFF1E1466), null),
    KarmaCategory.food_waste: new TileData(Color(0xFFFA7D82), Color(0xFFFFB295), 'assets/images/lunch.png'),
    KarmaCategory.recycling: new TileData(Color(0xFFFA7D82), Color(0xFFFFB295), 'assets/images/snack.png'),
    KarmaCategory.water_usage: new TileData(Color(0xFFFA7D82), Color(0xFFFFB295), 'assets/images/lunch.png'),
  };

  TaskListData.fromKarmaTask(KarmaTask task) {
    titleText = Helper.categoryDisplay(task.category);
    taskInfo = task.task;
    karma = task.points;
    startColor = colorsMap[task.category].color1;
    endColor = colorsMap[task.category].color2;
    imagePath = colorsMap[task.category].path;
  }

  static List<TaskListData> tabIconsList = <TaskListData>[
    TaskListData(
      imagePath: 'assets/images/breakfast.png',
      titleText: 'Recycle',
      karma: 20,
      taskInfo: 'Throw your unused water bottles in the reycling',
      startColor: Color(0xFFFA7D82),
      endColor: Color(0xFFFFB295),
    ),
    TaskListData(
      imagePath: 'assets/images/lunch.png',
      titleText: 'Bike',
      karma: 60,
      taskInfo: 'Take your bike to work instead of your car',
      startColor: Color(0xFF738AE6),
      endColor: Color(0xFF5C5EDD),
    ),
    TaskListData(
      imagePath: 'assets/images/snack.png',
      titleText: 'Plant',
      karma: 30,
      taskInfo: 'Plant a new vegetable in your garden',
      startColor: Color(0xFFFE95B6),
      endColor: Color(0xFFFF5287),
    ),
    TaskListData(
      imagePath: 'assets/images/dinner.png',
      titleText: 'Conserve',
      karma: 50,
      taskInfo: 'Fix your leaky faucet',
      startColor: Color(0xFF6F72CA),
      endColor: Color(0xFF1E1466),
    ),
  ];
}
