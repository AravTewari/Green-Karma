import 'package:flutter/material.dart';
import 'package:green_karma/common/globals.dart';
import 'package:green_karma/common/loading.dart';
import 'package:green_karma/home/home_screen.dart';
import 'package:green_karma/models/green_karma_user.dart';
import 'package:green_karma/services/auth_service.dart';
import 'package:green_karma/services/profile_service.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GreenKarmaUser _user;

  @override
  Widget build(BuildContext context) {
    _user = Provider.of<GreenKarmaUser>(context);

    return FutureBuilder<GreenKarmaUser>(
      future: onAppStartup(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            String errorText = 'Error: No connection state.';
            return getErrorScafold(context, errorText);
          case ConnectionState.waiting:
            return Loading();
          default:
            if (snapshot.hasError) {
              String errorText = 'Error: ${snapshot.error}';
              return getErrorScafold(context, errorText);
            } else {
              GreenKarmaUser resultUser = snapshot.data;
              assert(resultUser.profile != null);

              return HomeScreen();
            }
        }
      },
    );
  }

  Future<GreenKarmaUser> onAppStartup() async {
    UserProfileService profileService = UserProfileService(user: _user);

    _user.profile = await profileService.getOrCreateUserProfile();

    if (_user.profile.displayName == null) {
      _user.profile.displayName = globalDisplayName;

      await profileService.updateUserProfile();
    }
    return _user;
  }

  Widget getErrorScafold(BuildContext context, String errorText) {
    String fixedText = 'Please try again later. ' +
        '\n\nIf the problem persists, please email "contact@greenkarma.org" and specify the error.';
    return Scaffold(
      appBar: AppBar(
        title: Text('Error'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                AuthService auth = AuthService();
                auth.signOut();
              })
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.error,
            color: Colors.red,
            size: 130,
          ),
          const SizedBox(height: 30),
          Text(
            "OOPS!\nSomething went wrong!\nIt's not you, it's us.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w800,
              color: Colors.grey,
            ),
          ),
          Text(
            '$fixedText\n\n$errorText',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
