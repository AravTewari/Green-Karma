import 'package:flutter/material.dart';
import 'package:green_karma/common/bottom_bar_view.dart';
import 'package:green_karma/common/theme.dart';
import 'package:green_karma/home/add/task_categories.dart';
import 'package:green_karma/home/dashboard.dart';
import 'package:green_karma/home/rewards.dart';
import 'package:green_karma/home/training_screen.dart';
import 'package:green_karma/models/tab_icon_data.dart';
import 'package:green_karma/home/friends.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AnimationController animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: AppTheme.background,
  );

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = Dashboard(animationController: animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return Stack(
                children: <Widget>[
                  tabBody,
                  bottomBar(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<bool> getData() async {
    return true;
  }

  void refresher(Widget widget) {
    setState(() {
      tabBody = widget;
    });
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {
            animationController.reverse().then<dynamic>((data) {
              if (!mounted) {
                return;
              }
              setState(() {
                tabBody = TaskCategories(
                  tabBody: tabBody,
                  refresher: refresher,
                  animationController: animationController,
                  animation: Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animationController,
                      curve: Interval(
                        0,
                        1.0,
                        curve: Curves.fastOutSlowIn,
                      ),
                    ),
                  ),
                );
              });
            });
          },
          changeIndex: (int index) {
            if (index == 0) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = Dashboard(animationController: animationController);
                });
              });
            } else if (index == 1) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = Friends(animationController: animationController);
                });
              });
            } else if (index == 2) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = Rewards(animationController: animationController);
                });
              });
            } else if (index == 3) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = TrainingScreen(animationController: animationController);
                });
              });
            }
          },
        ),
      ],
    );
  }
}
