import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:green_karma/common/theme.dart';
import 'package:green_karma/home/add/category_tasks.dart';
import 'package:green_karma/models/green_karma_user.dart';
import 'package:green_karma/models/karma.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class TaskCategories extends StatefulWidget {
  Widget tabBody;
  Function refresher;

  final AnimationController animationController;
  final Animation animation;

  TaskCategories({this.tabBody, this.refresher, this.animation, this.animationController});

  @override
  _TaskCategoriesState createState() => _TaskCategoriesState();
}

class _TaskCategoriesState extends State<TaskCategories> {
  // ignore: unused_field
  GreenKarmaUser _user;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    _user = Provider.of<GreenKarmaUser>(context);

    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Container(
            width: screenWidth,
            height: MediaQuery.of(context).size.height,
          ),
          ClipPath(
            clipper: WaveClipperTwo(),
            child: Image.asset(
              'assets/images/add_task_one.jpg',
            ),
          ),
          Positioned(
            top: 280,
            left: 25,
            child: Container(
              child: Text(
                'Task Categories',
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
            top: 320,
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
      ),
    );
  }

  Widget getCategories(BuildContext context) {
    return Wrap(
      spacing: 16.0,
      runSpacing: 10.0,
      children: <Widget>[
        ActionChip(
          label: Text('Food waste'),
          onPressed: () {
            widget.refresher(CategoryTasks(category: KarmaCategory.food_waste, refresher: widget.refresher));
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
        ActionChip(
          label: Text('Electricity'),
          onPressed: () {
            widget.refresher(CategoryTasks(category: KarmaCategory.electricity, refresher: widget.refresher));
          },
          backgroundColor: Colors.blue,
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
        ActionChip(
          label: Text('Commute'),
          onPressed: () {
            widget.refresher(CategoryTasks(category: KarmaCategory.commute, refresher: widget.refresher));
          },
          backgroundColor: Colors.green,
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
        ActionChip(
          label: Text('Water usage'),
          onPressed: () {
            widget.refresher(CategoryTasks(category: KarmaCategory.water_usage, refresher: widget.refresher));
          },
          backgroundColor: Colors.amber,
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
        ActionChip(
          label: Text('Eco-friendly purchase'),
          onPressed: () {
            widget.refresher(CategoryTasks(category: KarmaCategory.ecofriendly_purchase, refresher: widget.refresher));
          },
          backgroundColor: Colors.purple,
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
        ActionChip(
          label: Text('Community service'),
          onPressed: () {
            widget.refresher(CategoryTasks(category: KarmaCategory.community_service, refresher: widget.refresher));
          },
          backgroundColor: Colors.indigo,
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
        ActionChip(
          label: Text('Recycling'),
          onPressed: () {
            widget.refresher(CategoryTasks(category: KarmaCategory.recycling, refresher: widget.refresher));
          },
          backgroundColor: Colors.orange,
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
        ActionChip(
          label: Text('Other'),
          onPressed: () {
            print('Other');
          },
          backgroundColor: Colors.grey[500],
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
      ],
    );
  }
}
