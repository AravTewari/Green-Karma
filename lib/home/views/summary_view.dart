import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:green_karma/common/theme.dart';
import 'package:green_karma/models/green_karma_user.dart';
import 'package:green_karma/services/profile_service.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Summary extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;
  GreenKarmaUser _user;

  double level = 0;
  int foo1 = 0;
  int foo2 = 0;
  int foo3 = 0;
  int numTasks = 0;

  Summary({Key key, this.animationController, this.animation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _user = Provider.of<GreenKarmaUser>(context);
    getNumbers();
    print(_user.profile.toJson());

    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: new Transform(
            transform: new Matrix4.translationValues(0.0, 30 * (1.0 - animation.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 18),
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(68.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(color: AppTheme.grey.withOpacity(0.2), offset: Offset(1.1, 1.1), blurRadius: 10.0),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        height: 48,
                                        width: 2,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF87A0E5).withOpacity(0.5),
                                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(left: 4, bottom: 2),
                                              child: Text(
                                                'Tasks completed',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: AppTheme.fontName,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                  letterSpacing: -0.1,
                                                  color: AppTheme.grey.withOpacity(0.5),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: <Widget>[
                                                SizedBox(
                                                  width: 28,
                                                  height: 28,
                                                  child: Image.asset("assets/images/eaten.png"),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 4, bottom: 3),
                                                  child: FutureBuilder(
                                                      future: UserProfileService(user: _user).getNumberOfTasks(),
                                                      builder: (context, snapshot) {
                                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                                          return CircularProgressIndicator();
                                                        }
                                                        return Text(
                                                          '${(snapshot.data * animation.value).toInt()}',
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                            fontFamily: AppTheme.fontName,
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 16,
                                                            color: AppTheme.darkerText,
                                                          ),
                                                        );
                                                      }),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 4, bottom: 3),
                                                  child: Text(
                                                    'tasks',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: AppTheme.fontName,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 12,
                                                      letterSpacing: -0.2,
                                                      color: AppTheme.grey.withOpacity(0.5),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        height: 48,
                                        width: 2,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFF56E98).withOpacity(0.5),
                                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(left: 4, bottom: 2),
                                              child: Text(
                                                'Streak',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: AppTheme.fontName,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                  letterSpacing: -0.1,
                                                  color: AppTheme.grey.withOpacity(0.5),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: <Widget>[
                                                SizedBox(
                                                  width: 28,
                                                  height: 28,
                                                  child: Image.asset("assets/images/burned.png"),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 4, bottom: 3),
                                                  child: Text(
                                                    '${(5 * animation.value).toInt()}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: AppTheme.fontName,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 16,
                                                      color: AppTheme.darkerText,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 8, bottom: 3),
                                                  child: Text(
                                                    'days',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: AppTheme.fontName,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 12,
                                                      letterSpacing: -0.2,
                                                      color: AppTheme.grey.withOpacity(0.5),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Center(
                              child: Stack(
                                overflow: Overflow.visible,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: AppTheme.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(100.0),
                                        ),
                                        border: new Border.all(width: 4, color: AppTheme.primary.withOpacity(0.2)),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            'LEVEL',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: AppTheme.fontName,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              letterSpacing: 0.0,
                                              color: AppTheme.grey.withOpacity(0.5),
                                            ),
                                          ),
                                          Text(
                                            '${(level * animation.value).toInt()}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: AppTheme.fontName,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 24,
                                              letterSpacing: 0.0,
                                              color: AppTheme.primary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: CustomPaint(
                                      painter: CurvePainter(
                                        colors: [AppTheme.primary, Color(0xFF8A98E8), Color(0xFF8A98E8)],
                                        angle: ((_user.profile.karmaPoints % 200) * 1.8) +
                                            (360 - ((_user.profile.karmaPoints % 200) * 1.8)) * (1.0 - animation.value),
                                      ),
                                      child: SizedBox(
                                        width: 108,
                                        height: 108,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 8),
                      child: Container(
                        height: 2,
                        decoration: BoxDecoration(
                          color: AppTheme.background,
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 16),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '${_user.profile.badges[foo1].name.split(" ").join("\n")}',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: AppTheme.fontName,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    letterSpacing: -0.2,
                                    color: AppTheme.darkText,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Container(
                                    height: 4,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF87A0E5).withOpacity(0.2),
                                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: ((_user.profile.badges[foo1].completedDecimal * 70) * animation.value),
                                          height: 4,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(colors: [
                                              Color(0xFF87A0E5),
                                              Color(0xFF87A0E5).withOpacity(0.5),
                                            ]),
                                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Text(
                                    '${_user.profile.badges[foo1].numberOfTasksLeft} tasks left',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: AppTheme.fontName,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: AppTheme.grey.withOpacity(0.5),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '${_user.profile.badges[foo2].name.split(" ").join("\n")}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: AppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        letterSpacing: -0.2,
                                        color: AppTheme.darkText,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Container(
                                        height: 4,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFF56E98).withOpacity(0.2),
                                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                        ),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              width: ((_user.profile.badges[foo2].completedDecimal * 70) *
                                                  animationController.value),
                                              height: 4,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(colors: [
                                                  Color(0xFFF56E98).withOpacity(0.1),
                                                  Color(0xFFF56E98),
                                                ]),
                                                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        '${_user.profile.badges[foo2].numberOfTasksLeft} tasks left',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: AppTheme.fontName,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: AppTheme.grey.withOpacity(0.5),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '${_user.profile.badges[foo3].name.split(" ").join("\n")}',
                                      style: TextStyle(
                                        fontFamily: AppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        letterSpacing: -0.2,
                                        color: AppTheme.darkText,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 0, top: 4),
                                      child: Container(
                                        height: 4,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFF1B440).withOpacity(0.2),
                                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                        ),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              width: ((_user.profile.badges[foo3].completedDecimal * 70) *
                                                  animationController.value),
                                              height: 4,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(colors: [
                                                  Color(0xFFF1B440).withOpacity(0.1),
                                                  Color(0xFFF1B440),
                                                ]),
                                                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        '${_user.profile.badges[foo3].numberOfTasksLeft} tasks left',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: AppTheme.fontName,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: AppTheme.grey.withOpacity(0.5),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void getNumbers() {
    level = _user.profile.karmaPoints / 200;
    if (level < 1) {
      level = 1.0;
    }

    foo1 = 1;
    foo2 = 2;
    foo3 = 3;
  }
}

class CurvePainter extends CustomPainter {
  final double angle;
  final List<Color> colors;

  CurvePainter({this.colors, this.angle = 140});

  @override
  void paint(Canvas canvas, Size size) {
    List<Color> colorsList = List<Color>();
    if (colors != null) {
      colorsList = colors;
    } else {
      colorsList.addAll([Colors.white, Colors.white]);
    }

    final shdowPaint = new Paint()
      ..color = Colors.black.withOpacity(0.4)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
    final shdowPaintCenter = new Offset(size.width / 2, size.height / 2);
    final shdowPaintRadius = math.min(size.width / 2, size.height / 2) - (14 / 2);
    canvas.drawArc(new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius), degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)), false, shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.3);
    shdowPaint.strokeWidth = 16;
    canvas.drawArc(new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius), degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)), false, shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.2);
    shdowPaint.strokeWidth = 20;
    canvas.drawArc(new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius), degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)), false, shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.1);
    shdowPaint.strokeWidth = 22;
    canvas.drawArc(new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius), degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)), false, shdowPaint);

    final rect = new Rect.fromLTWH(0.0, 0.0, size.width, size.width);
    final gradient = new SweepGradient(
      startAngle: degreeToRadians(268),
      endAngle: degreeToRadians(270.0 + 360),
      tileMode: TileMode.repeated,
      colors: colorsList,
    );
    final paint = new Paint()
      ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.round // StrokeCap.round is not recommended.
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
    final center = new Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2) - (14 / 2);

    canvas.drawArc(new Rect.fromCircle(center: center, radius: radius), degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)), false, paint);

    final gradient1 = new SweepGradient(
      tileMode: TileMode.repeated,
      colors: [Colors.white, Colors.white],
    );

    var cPaint = new Paint();
    cPaint..shader = gradient1.createShader(rect);
    cPaint..color = Colors.white;
    cPaint..strokeWidth = 14 / 2;
    canvas.save();

    final centerToCircle = size.width / 2;
    canvas.save();

    canvas.translate(centerToCircle, centerToCircle);
    canvas.rotate(degreeToRadians(angle + 2));

    canvas.save();
    canvas.translate(0.0, -centerToCircle + 14 / 2);
    canvas.drawCircle(new Offset(0, 0), 14 / 5, cPaint);

    canvas.restore();
    canvas.restore();
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  double degreeToRadians(double degree) {
    var redian = (math.pi / 180) * degree;
    return redian;
  }
}
