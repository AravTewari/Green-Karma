import 'package:flutter/material.dart';

class TabIconData {
  TabIconData({
    this.imagePath = '',
    this.index = 0,
    this.selectedImagePath = '',
    this.isSelected = false,
    this.animationController,
  });

  String imagePath;
  String selectedImagePath;
  bool isSelected;
  int index;

  AnimationController animationController;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      imagePath: 'assets/images/home_home.png',
      selectedImagePath: 'assets/images/home_home_s.png',
      index: 0,
      isSelected: true,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/images/home_friends.png',
      selectedImagePath: 'assets/images/home_friends_s.png',
      index: 1,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/images/home_rewards.png',
      selectedImagePath: 'assets/images/home_rewards_s.png',
      index: 2,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/images/home_settings.png',
      selectedImagePath: 'assets/images/home_settings_s.png',
      index: 3,
      isSelected: false,
      animationController: null,
    ),
  ];
}
