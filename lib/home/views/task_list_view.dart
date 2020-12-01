import 'package:flutter/material.dart';
import 'package:green_karma/common/theme.dart';
import 'package:green_karma/models/green_karma_user.dart';
import 'package:green_karma/models/karma.dart';
import 'package:green_karma/models/task_list_data.dart';
import 'package:green_karma/services/profile_service.dart';
import 'package:provider/provider.dart';

class TaskListView extends StatefulWidget {
  const TaskListView({Key key, this.mainScreenAnimationController, this.mainScreenAnimation}) : super(key: key);

  final AnimationController mainScreenAnimationController;
  final Animation<dynamic> mainScreenAnimation;

  @override
  _TaskListViewState createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> with TickerProviderStateMixin {
  AnimationController animationController;
  List<TaskListData> tasksListData = List<TaskListData>();

  GreenKarmaUser _user;

  @override
  void initState() {
    animationController = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _user = Provider.of<GreenKarmaUser>(context);

    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.mainScreenAnimation,
          child: Transform(
            transform: Matrix4.translationValues(0.0, 30 * (1.0 - widget.mainScreenAnimation.value), 0.0),
            child: Container(
              height: 216,
              width: double.infinity,
              child: FutureBuilder(
                  future: getData(),
                  builder: (buildContext, asyncSnapshot) {
                    return ListView.builder(
                      padding: const EdgeInsets.only(top: 0, bottom: 0, right: 16, left: 16),
                      itemCount: tasksListData.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        final int count = tasksListData.length > 10 ? 10 : tasksListData.length;
                        final Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                            parent: animationController,
                            curve: Interval((1 / count) * index, 1.0, curve: Curves.fastOutSlowIn)));
                        animationController.forward();

                        return TaskView(
                          taskListData: tasksListData[index],
                          animation: animation,
                          animationController: animationController,
                        );
                      },
                    );
                  }),
            ),
          ),
        );
      },
    );
  }

  Future getData() async {
    tasksListData.clear();

    UserProfileService service = UserProfileService(user: _user);
    List<KarmaTask> list = await service.getAllCompletedTasks();
    list.forEach((element) {
      tasksListData.add(TaskListData.fromKarmaTask(element));
    });
  }
}

class TaskView extends StatelessWidget {
  const TaskView({Key key, this.taskListData, this.animationController, this.animation}) : super(key: key);

  final TaskListData taskListData;
  final AnimationController animationController;
  final Animation<dynamic> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(100 * (1.0 - animation.value), 0.0, 0.0),
            child: SizedBox(
              width: 130,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 32, left: 8, right: 8, bottom: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: taskListData.endColor.withOpacity(0.6),
                              offset: const Offset(1.1, 4.0),
                              blurRadius: 8.0),
                        ],
                        gradient: LinearGradient(
                          colors: [
                            taskListData.startColor,
                            taskListData.endColor,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0),
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(54.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 54, left: 8, right: 16, bottom: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              taskListData.titleText,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: AppTheme.fontName,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                letterSpacing: 0.2,
                                color: AppTheme.white,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8, bottom: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        taskListData.taskInfo,
                                        style: TextStyle(
                                          fontFamily: AppTheme.fontName,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10,
                                          letterSpacing: 0.2,
                                          color: AppTheme.white,
                                        ),
                                        overflow: TextOverflow.visible,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            taskListData.karma != 0
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        '+${taskListData.karma.toString()}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: AppTheme.fontName,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 24,
                                          letterSpacing: 0.2,
                                          color: AppTheme.white,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 4, bottom: 3),
                                        child: Text(
                                          'karma',
                                          style: TextStyle(
                                            fontFamily: AppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10,
                                            letterSpacing: 0.2,
                                            color: AppTheme.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      color: AppTheme.nearlyWhite,
                                      shape: BoxShape.circle,
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            color: AppTheme.nearlyBlack.withOpacity(0.4),
                                            offset: Offset(8.0, 8.0),
                                            blurRadius: 8.0),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Icon(
                                        Icons.add,
                                        color: taskListData.endColor,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: 84,
                      height: 84,
                      decoration: BoxDecoration(
                        color: AppTheme.nearlyWhite.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 8,
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: Image.asset(taskListData.imagePath),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
