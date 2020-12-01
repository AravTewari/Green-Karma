import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:green_karma/common/helper.dart';
import 'package:green_karma/common/theme.dart';
import 'package:green_karma/home/add/category_tasks.dart';
import 'package:green_karma/models/activity.dart';
import 'package:green_karma/models/green_karma_user.dart';
import 'package:green_karma/models/karma.dart';
import 'package:green_karma/services/activity_service.dart';
import 'package:green_karma/services/profile_service.dart';
import 'package:green_karma/services/storage_service.dart';
import 'package:provider/provider.dart';

class AddActivity extends StatefulWidget {
  final KarmaTask task;
  final Function refresher;

  AddActivity({this.task, this.refresher});

  @override
  _AddActivityState createState() => _AddActivityState();
}

class _AddActivityState extends State<AddActivity> {
  TextEditingController con1 = TextEditingController();
  TextEditingController con2 = TextEditingController();

  GreenKarmaUser _currentUser;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _error;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    _currentUser = Provider.of<GreenKarmaUser>(context);
    File imageFile;

    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              width: screenWidth,
              height: MediaQuery.of(context).size.height,
              color: AppTheme.secondary,
            ),
            ClipPath(
              clipper: WaveClipperTwo(),
              child: Image.asset('assets/images/11092.jpg'),
            ),
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: (() {
                widget.refresher(
                  CategoryTasks(
                    category: widget.task.category,
                    refresher: widget.refresher,
                  ),
                );
              }),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 275),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      widget.task.task,
                      style: TextStyle(
                        fontFamily: AppTheme.fontName,
                        fontWeight: FontWeight.w700,
                        fontSize: 28,
                        letterSpacing: 0.5,
                        color: AppTheme.nearlyWhite,
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 325,
                      child: TextField(
                        controller: con1,
                        decoration: InputDecoration(
                          labelText: 'What did you cook?',
                          labelStyle: TextStyle(
                            fontFamily: AppTheme.fontName,
                            fontWeight: FontWeight.w100,
                            fontSize: 16,
                            letterSpacing: 0.5,
                            color: AppTheme.nearlyWhite,
                          ),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(color: AppTheme.nearlyWhite),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(color: AppTheme.nearlyWhite),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: 325,
                      child: TextField(
                        controller: con2,
                        minLines: 3,
                        maxLines: 5,
                        decoration: InputDecoration(
                          labelText: 'Caption',
                          labelStyle: TextStyle(
                            fontFamily: AppTheme.fontName,
                            fontWeight: FontWeight.w100,
                            fontSize: 16,
                            letterSpacing: 0.5,
                            color: AppTheme.nearlyWhite,
                          ),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(color: AppTheme.nearlyWhite),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(color: AppTheme.nearlyWhite),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () async {
                        try {
                          setState(() async {
                            imageFile = await pickImageFromDevice(context);
                          });
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.add_a_photo_outlined,
                            color: AppTheme.nearlyWhite,
                          ),
                          SizedBox(width: 3),
                          Text(
                            'Add photo',
                            style: TextStyle(
                              fontFamily: AppTheme.fontName,
                              fontWeight: FontWeight.w100,
                              fontSize: 12,
                              letterSpacing: 0.5,
                              color: AppTheme.nearlyWhite,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    imageFile != null
                        ? Icon(Icons.check_circle_outline_outlined, color: AppTheme.nearlyWhite)
                        : SizedBox(),
                    SizedBox(height: 20),
                    FlatButton(
                      minWidth: 325,
                      color: AppTheme.nearlyWhite,
                      onPressed: (() async {
                        _error = '';
                        if (con2.text == null || con1.text == null || con2.text.isEmpty || con1.text.isEmpty) {
                          _error = 'Please fill out all text fields';
                        }

                        if (imageFile == null) {
                          _error = 'Please select an image';
                        }

                        if (_error.isNotEmpty) {
                          AlertDialog alert = AlertDialog(
                            title: Text('Incomplete!'),
                            content: Text(_error),
                            actions: [
                              FlatButton(
                                child: Text(
                                  "OK",
                                  style: TextStyle(fontFamily: AppTheme.fontName, color: AppTheme.primary),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          );

                          // show the dialog
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            },
                          );
                          return;
                        }

                        Activity activity = Activity(
                          avatarPhotoUrl: null,
                          caption: con2.text,
                          friendName: _currentUser.profile.displayName,
                          likes: 0,
                          comments: 0,
                          shares: 0,
                        );

                        StorageService storageService = StorageService();
                        String url = await storageService.uploadImage(imageFile);
                        activity.imageUrl = url;

                        activity.friendDocRef = UserProfileService.referenceFromId(_currentUser.profileDocId);

                        ActivityService service = ActivityService();
                        await service.createActivity(activity);

                        UserProfileService profileService = UserProfileService(user: _currentUser);
                        await profileService.addTask(widget.task);
                      }),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          fontFamily: AppTheme.fontName,
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                          letterSpacing: 0.5,
                          color: AppTheme.secondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
