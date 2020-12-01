import 'package:flutter/material.dart';
import 'package:green_karma/common/loading.dart';
import 'package:green_karma/common/theme.dart';
import 'package:green_karma/home/views/reward_view.dart';
import 'package:green_karma/home/views/title_view.dart';
import 'package:green_karma/home/views/point_and_level_view.dart';
import 'package:green_karma/models/reward.dart';
import 'package:green_karma/services/reward_service.dart';
import 'package:intl/intl.dart';

class Rewards extends StatefulWidget {
  const Rewards({Key key, this.animationController}) : super(key: key);
  final AnimationController animationController;

  @override
  _RewardsState createState() => _RewardsState();
}

class _RewardsState extends State<Rewards> {
  int i = 0;
  int count = 5;

  Animation<double> topBarAnimation;
  RewardService rewardService = RewardService();

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;
  bool firstTime = true;

  static DateTime now = DateTime.now();
  String formattedDate = DateFormat('MMMd').format(now);

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: widget.animationController, curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 && scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });

    addAllListData();

    super.initState();
  }

  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  // populates listView with the widgets for the actual UI stuff on the page
  addAllListData() {
    listViews.add(
      TitleView(
        titleTxt: 'Current Level',
        subTxt: 'See More',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(
              (1 / count) * i,
              1.0,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        animationController: widget.animationController,
      ),
    );
    i++;

    listViews.add(
      PointAndLevelView(
        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(
              (1 / count) * i,
              1.0,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        mainScreenAnimationController: widget.animationController,
      ),
    );
    i++;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getMainListViewUI(),
            getAppBarUI(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Future<bool> getData() async {
    List<Reward> stuff = await rewardService.getAllRewards();
    count = stuff.length + 2;

    stuff.forEach((element) {
      listViews.add(RewardView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(
              (1 / count) * i,
              1.0,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        animationController: widget.animationController,
        reward: element,
      ));
      i++;
    });
    return true;
  }

  Widget getMainListViewUI() {
    return FutureBuilder<void>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (!snapshot.hasData) {
          return Loading();
        } else {
          return ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.only(
              top: AppBar().preferredSize.height + MediaQuery.of(context).padding.top + 24,
              bottom: 62 + MediaQuery.of(context).padding.bottom,
            ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              widget.animationController.forward();
              return listViews[index];
            },
          );
        }
      },
    );
  }

  Widget getAppBarUI() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController,
          builder: (BuildContext context, Widget child) {
            return FadeTransition(
              opacity: topBarAnimation,
              child: Transform(
                transform: Matrix4.translationValues(0.0, 30 * (1.0 - topBarAnimation.value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.white.withOpacity(topBarOpacity),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: AppTheme.grey.withOpacity(0.4 * topBarOpacity),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 24.0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16, right: 16, top: 16 - 8.0 * topBarOpacity, bottom: 12 - 8.0 * topBarOpacity),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Rewards',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: AppTheme.fontName,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22 + 6 - 6 * topBarOpacity,
                                    letterSpacing: 1.2,
                                    color: AppTheme.darkerText,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 38,
                              width: 38,
                              child: InkWell(
                                highlightColor: Colors.transparent,
                                borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                                onTap: () {},
                                child: Center(
                                  child: Icon(
                                    Icons.keyboard_arrow_left,
                                    color: AppTheme.grey,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 8,
                                right: 8,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: Icon(
                                      Icons.shield,
                                      color: AppTheme.grey,
                                      size: 18,
                                    ),
                                  ),
                                  Text(
                                    'Badges',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: AppTheme.fontName,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18,
                                      letterSpacing: -0.2,
                                      color: AppTheme.darkerText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 38,
                              width: 38,
                              child: InkWell(
                                highlightColor: Colors.transparent,
                                borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                                onTap: () {},
                                child: Center(
                                  child: Icon(
                                    Icons.keyboard_arrow_right,
                                    color: AppTheme.grey,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
