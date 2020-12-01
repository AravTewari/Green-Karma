import 'package:flutter/material.dart';
import 'package:green_karma/common/theme.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:green_karma/models/green_karma_user.dart';
import 'package:provider/provider.dart';

class PointAndLevelView extends StatefulWidget {
  const PointAndLevelView({Key key, this.mainScreenAnimationController, this.mainScreenAnimation}) : super(key: key);

  final AnimationController mainScreenAnimationController;
  final Animation<dynamic> mainScreenAnimation;

  @override
  _PointAndLevelViewState createState() => _PointAndLevelViewState();
}

class _PointAndLevelViewState extends State<PointAndLevelView> with TickerProviderStateMixin {
  GreenKarmaUser _user;

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
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
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 45),
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(color: AppTheme.grey.withOpacity(0.2), offset: const Offset(1.1, 1.1), blurRadius: 10.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 2, bottom: 3),
                                    child: Text(
                                      'Current points',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: AppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        letterSpacing: 0.0,
                                        color: AppTheme.darkText,
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 3),
                                      child: Text(
                                        '${_user.profile.karmaPoints}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: AppTheme.fontName,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 32,
                                          color: AppTheme.primary,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8, bottom: 8),
                                      child: Text(
                                        'karma',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: AppTheme.fontName,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                          letterSpacing: -0.2,
                                          color: AppTheme.primary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4, right: 4, top: 8, bottom: 10),
                              child: Container(
                                height: 2,
                                decoration: BoxDecoration(
                                  color: AppTheme.background,
                                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Center(
                                child: Text(
                                  'Level ${_user.profile.karmaPoints ~/ 200}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: AppTheme.fontName,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color: AppTheme.primary,
                                  ),
                                ),
                              ),
                            ),
                            FAProgressBar(
                              currentValue: ((_user.profile.karmaPoints % 200) * 0.5).toInt(),
                              backgroundColor: AppTheme.primary.withOpacity(0.3),
                              progressColor: AppTheme.primary,
                              borderRadius: 16,
                              size: 15,
                              animatedDuration: Duration(milliseconds: 600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
