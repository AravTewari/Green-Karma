import 'dart:io';

import 'package:flutter/material.dart';
import 'package:green_karma/models/karma.dart';
import 'package:green_karma/services/auth_service.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class WidgetHelper {
  static AppBar makeAppBar(BuildContext context) {
    return AppBar(
      title: Text('Green Karma'),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          print('back button pressed!');
        },
      ),
      automaticallyImplyLeading: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.menu),
          onPressed: () async {
            AuthService _auth = AuthService();
            await _auth.signOut();
          },
        )
      ],
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  static Widget getBeautifulDivider(BuildContext coontext) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 55,
            height: 1,
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              'OR',
              style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: 55,
            height: 1,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

class MyWidgets {
  static final sizeBox5 = SizedBox(height: 5);
  static final sizeBox10 = SizedBox(height: 10);
  static final sizeBox15 = SizedBox(height: 15);
  static final sizeBox20 = SizedBox(height: 20);
}

class Helper {
  /// Converts any enum to a formatted string
  /// Takes in an [Object] and takes out the enum part
  static String e2s(Object o) {
    return o.toString().split('.').last;
  }

  /// Converts any string to enum
  ///
  /// Takes the [key] and checks it against the [values]
  /// Returns an [Enum] if it exists in [values]
  /// Returns [null] if it does not
  static T s2e<T>(String key, Iterable<T> values) => values.firstWhere(
        (v) => v != null && key == e2s(v),
        orElse: () => null,
      );

  /// Checks if [s] is empty or null
  static bool isEmpty(String s) {
    return (s == null || s.isEmpty);
  }

  /// Properly checks if [s] is blank
  static bool isBlank(String s) {
    return (isEmpty(s) || s.trimLeft().isEmpty);
  }

  static String categoryDisplay(KarmaCategory category) {
    String s = e2s(category);
    List<String> list = s.split('_');
    String foo = list.join(' ');

    return '${foo[0].toUpperCase()}${foo.substring(1)}';
  }
}

Future<File> pickImageFromDevice(BuildContext context) async {
  try {
    ImagePicker picker = ImagePicker();
    PickedFile pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile == null) return null;

    File imageFile = File(pickedFile.path);

    File croppedImage = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      maxWidth: 300,
      maxHeight: 300,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'Cropper',
        toolbarColor: Colors.deepOrange,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      ),
      iosUiSettings: IOSUiSettings(
        minimumAspectRatio: 1.0,
      ),
    );

    return croppedImage;
  } catch (e) {
    print(e.toString());
    return null;
  }
}
