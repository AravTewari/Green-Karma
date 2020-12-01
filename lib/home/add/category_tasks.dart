import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:green_karma/common/globals.dart';
import 'package:green_karma/common/helper.dart';
import 'package:green_karma/common/theme.dart';
import 'package:green_karma/home/add/add_activity.dart';
import 'package:green_karma/models/green_karma_user.dart';
import 'package:green_karma/models/karma.dart';
import 'package:green_karma/services/profile_service.dart';
import 'package:provider/provider.dart';

class CategoryTasks extends StatefulWidget {
  final KarmaCategory category;
  final Function refresher;

  CategoryTasks({this.category, this.refresher});

  @override
  _CategoryTasksState createState() => _CategoryTasksState();
}

class _CategoryTasksState extends State<CategoryTasks> {
  GreenKarmaUser _user;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    _user = Provider.of<GreenKarmaUser>(context);

    return Stack(
      children: <Widget>[
        Container(width: screenWidth, height: MediaQuery.of(context).size.height),
        ClipPath(
          clipper: WaveClipperTwo(),
          child: Image.asset('assets/images/6608.jpg'),
        ),
        Positioned(
          top: 285,
          left: 25,
          child: Container(
            child: Text(
              Helper.categoryDisplay(widget.category),
              style: TextStyle(
                fontFamily: AppTheme.fontName,
                fontWeight: FontWeight.w700,
                fontSize: 28,
                letterSpacing: 0.5,
                color: AppTheme.dark_grey,
              ),
            ),
          ),
        ),
        Positioned(
          top: 325,
          child: Container(
            padding: EdgeInsets.only(top: 10, left: 0, bottom: 0, right: 10),
            height: 300,
            width: screenWidth,
            child: Column(
              children: <Widget>[
                getCategories(context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget getCategories(BuildContext context) {
    List<KarmaTask> stuff = AppGlobals.getAllTasksInCategory(widget.category);
    List<Widget> chips = List<Widget>();

    stuff.forEach((element) {
      chips.add(
        ActionChip(
          label: Text(element.task),
          onPressed: () async {
            // UserProfileService service = UserProfileService(user: _user);
            // await service.addTask(element);
            widget.refresher(AddActivity(
              task: element,
              refresher: widget.refresher,
            ));
          },
          backgroundColor: Colors.red,
          elevation: 3.0,
          labelStyle: TextStyle(
            fontFamily: AppTheme.fontName,
            fontWeight: FontWeight.w300,
            fontSize: 18,
            color: AppTheme.nearlyWhite,
          ),
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
        ),
      );
    });

    return Wrap(
      spacing: 16.0,
      runSpacing: 10.0,
      children: chips,
    );
  }
}
