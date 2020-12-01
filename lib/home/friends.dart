import 'package:flutter/material.dart';
import 'package:green_karma/common/loading.dart';
import 'package:green_karma/common/theme.dart';
import 'package:green_karma/home/views/activity_view.dart';
import 'package:green_karma/home/views/title_view.dart';
import 'package:green_karma/models/activity.dart';
import 'package:green_karma/models/green_karma_user.dart';
import 'package:green_karma/services/activity_service.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Friends extends StatefulWidget {
  const Friends({Key key, this.animationController}) : super(key: key);

  final AnimationController animationController;
  @override
  _FriendsState createState() => _FriendsState();
}

class _FriendsState extends State<Friends> with TickerProviderStateMixin {
  int i = 0;
  int count = 1;

  Animation<double> topBarAnimation;
  ActivityService activityService = ActivityService();

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  static DateTime now = DateTime.now();
  String formattedDate = DateFormat('MMMd').format(now);

  GreenKarmaUser user;

  // initializes the animation for the top app bar
  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: widget.animationController, curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    addAllListData();

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
    super.initState();
  }

  // populates listView with the widgets for the actual UI stuff on the page
  addAllListData() {
    listViews.add(
      TitleView(
        titleTxt: 'Recent activity',
        subTxt: 'Show more',
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
  }

  Future<bool> getData() async {
    List<Activity> stuff = await activityService.getFriendsActivities(user);
    count = stuff.length + 1;

    stuff.forEach((element) {
      listViews.add(ActivityView(
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
        activity: element,
      ));
      i++;
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<GreenKarmaUser>(context);

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

  // the main list of the page
  // gets list from listViews
  Widget getMainListViewUI() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
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

  // Top app bar with page name and current date
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
                        blurRadius: 10.0,
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
                                  'My Circle',
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
                                      Icons.search,
                                      color: AppTheme.grey,
                                      size: 18,
                                    ),
                                  ),
                                ],
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
