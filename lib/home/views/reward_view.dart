import 'package:flutter/material.dart';
import 'package:green_karma/common/theme.dart';
import 'package:green_karma/models/reward.dart';

class RewardView extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;
  final Reward reward;

  const RewardView({Key key, this.animationController, this.animation, this.reward}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: new Transform(
            transform: new Matrix4.translationValues(0.0, 30 * (1.0 - animation.value), 0.0),
            child: GestureDetector(
              onTap: () {
                // set up the button
                Widget okButton = FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                );

                // set up the AlertDialog
                AlertDialog alert = AlertDialog(
                  title: Text('Redeem your Lyft discount'),
                  content: Text('Head over to "lyft.com/partners/greenkarma" to redeem your discount!'),
                  actions: [
                    okButton,
                  ],
                );

                // show the dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return alert;
                  },
                );
              },
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24, top: 0, bottom: 0),
                    child: Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppTheme.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                bottomLeft: Radius.circular(8.0),
                                bottomRight: Radius.circular(8.0),
                                topRight: Radius.circular(8.0),
                              ),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: AppTheme.grey.withOpacity(0.4),
                                  offset: Offset(1.1, 1.1),
                                  blurRadius: 10.0,
                                ),
                              ],
                            ),
                            child: Stack(
                              alignment: Alignment.topLeft,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                    child: SizedBox(
                                      height: 54,
                                      child: Image.network(
                                        reward.photoUrl,
                                        width: 90,
                                        height: 90,
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 90,
                                            right: 16,
                                            top: 16,
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                "${reward.company} ",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontFamily: AppTheme.fontName,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 18,
                                                  letterSpacing: 0.0,
                                                  color: AppTheme.primary,
                                                ),
                                              ),
                                              Text(
                                                "• ${reward.offer}",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontFamily: AppTheme.fontName,
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 15,
                                                  letterSpacing: 0.0,
                                                  color: AppTheme.darkerText,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 90,
                                        bottom: 12,
                                        top: 4,
                                        right: 16,
                                      ),
                                      child: Text(
                                        "${reward.karmaNeeded} Karma",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontFamily: AppTheme.fontName,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                          letterSpacing: 0.0,
                                          color: AppTheme.grey.withOpacity(0.5),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
