import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:green_karma/auth/auth.dart';
import 'package:green_karma/common/colors.dart';
import 'package:green_karma/home/home.dart';
import 'package:green_karma/models/green_karma_user.dart';
import 'package:green_karma/services/auth_service.dart';
import 'package:provider/provider.dart';

import 'common/globals.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AppGlobals.initialize();
  runApp(new GreenKarmaApp());
}

class GreenKarmaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<GreenKarmaUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: MyTheme.themeData,
        home: Wrapper(),
      ),
    );
  }
}

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<GreenKarmaUser>(context);

    if (_user == null) {
      return Auth();
    } else {
      return Home();
    }
  }
}
