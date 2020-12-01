import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:green_karma/common/colors.dart';
import 'package:green_karma/common/helper.dart';
import 'package:green_karma/common/loading.dart';
import 'package:green_karma/services/auth_service.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  int minPasswordLen = 6;
  int _tabViewIndex = 0;

  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool loading = false;

  static final RegExp emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  //Text field state
  String _loginEmail = '';
  String _loginPassword = '';
  String _forgotEmail = '';

  String _registerEmail = '';
  String _registerName = '';
  String _registerPassword = '';
  String _registerPassword2 = '';

  String _googleText = 'Sign in with Google';
  String _error = '';

  int easterEggCounter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        top: false,
        bottom: false,
        left: false,
        right: false,
        child: loading
            ? Loading()
            : Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.red[400], Colors.pink[200]],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomLeft,
                  ),
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 50),
                        Image.asset(
                          'assets/images/gk_logo_trans_500.png',
                          width: 100,
                        ),
                        Text(
                          'Green Karma',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                        getTabs(context),
                        AnimatedCrossFade(
                          duration: Duration(milliseconds: 700),
                          firstChild: getLoginView(context),
                          secondChild: getRegisterView(context),
                          crossFadeState: _tabViewIndex == 0 ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget getLoginView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, left: 15, right: 15),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Stack(
              overflow: Overflow.visible,
              alignment: Alignment.topCenter,
              children: <Widget>[
                Container(
                  height: 200,
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0, left: 15, right: 15, bottom: 20),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          readOnly: (_tabViewIndex != 0),
                          initialValue: _loginEmail,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.grey,
                              ),
                              enabled: _tabViewIndex == 0,
                              labelText: 'Email',
                              //labelStyle: TextStyle(color: Colors.black87),
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent))),
                          keyboardType: TextInputType.emailAddress,
                          validator: (val) => val.isEmpty ? 'Enter a valid email' : null,
                          onChanged: (val) {
                            setState(() => _loginEmail = val);
                          },
                        ),
                        Divider(color: Colors.grey, height: 8),
                        TextFormField(
                          readOnly: (_tabViewIndex != 0),
                          initialValue: _loginPassword,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.grey,
                              ),
                              enabled: _tabViewIndex == 0,
                              labelText: 'Password',
                              //labelStyle: TextStyle(color: Colors.black87),
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent))),
                          obscureText: true,
                          validator: (val) => val.length < 6 ? 'Your password must be greater than 6 characters' : null,
                          onChanged: (val) {
                            setState(() => _loginPassword = val);
                          },
                        ),
                        Divider(
                          color: Colors.transparent,
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
                getLoginButton(context),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 45.0),
              child: GestureDetector(
                child: Center(
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                onTap: () {
                  handleForgotPassword(context);
                },
              ),
            ),
            WidgetHelper.getBeautifulDivider(context),
            MyWidgets.sizeBox20,
            googleSignInButton(context, _googleText),
          ],
        ),
      ),
    );
  }

  Widget getRegisterView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, left: 15, right: 15),
      child: Column(
        children: <Widget>[
          Stack(
            overflow: Overflow.visible,
            alignment: Alignment.topCenter,
            children: <Widget>[
              Container(
                //color: Colors.grey,
                height: 260,
              ),
              Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 15, right: 15, bottom: 20),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                          readOnly: (_tabViewIndex == 0),
                          initialValue: _registerName,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.grey,
                              ),
                              labelText: 'Name',
                              enabled: _tabViewIndex == 1,
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent))),
                          keyboardType: TextInputType.name,
                          validator: (val) => val.isEmpty ? 'Enter a valid name' : null,
                          onChanged: (val) {
                            setState(() => _registerName = val);
                          }),
                      Divider(color: Colors.grey, height: 8),
                      TextFormField(
                          readOnly: (_tabViewIndex == 0),
                          initialValue: _registerEmail,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.grey,
                              ),
                              labelText: 'Email',
                              enabled: _tabViewIndex == 1,
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent))),
                          keyboardType: TextInputType.emailAddress,
                          validator: (val) => val.isEmpty ? 'Enter a valid email' : null,
                          onChanged: (val) {
                            setState(() => _registerEmail = val);
                          }),
                      Divider(color: Colors.grey, height: 8),
                      TextFormField(
                        readOnly: (_tabViewIndex == 0),
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.grey,
                            ),
                            labelText: 'Password',
                            enabled: _tabViewIndex == 1,
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent))),
                        obscureText: true,
                        validator: (val) => val.length < minPasswordLen
                            ? 'Your password must be greater than $minPasswordLen characters'
                            : null,
                        onChanged: (val) {
                          setState(() => _registerPassword = val);
                        },
                      ),
                      Divider(color: Colors.grey, height: 8),
                      TextFormField(
                        readOnly: _tabViewIndex == 0,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.grey,
                            ),
                            labelText: 'Confirm Password',
                            enabled: _tabViewIndex == 1,
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent))),
                        obscureText: true,
                        validator: (val) => val.length < minPasswordLen
                            ? 'Your password must be greater than $minPasswordLen characters'
                            : null,
                        onChanged: (val) {
                          setState(() => _registerPassword2 = val);
                        },
                      ),
                      Divider(
                        color: Colors.transparent,
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
              getRegisterButton(context),
            ],
          ),
          WidgetHelper.getBeautifulDivider(context),
          MyWidgets.sizeBox20,
          googleSignInButton(context, _googleText),
        ],
      ),
    );
  }

  Widget getTabs(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 15, right: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.12),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    color: _tabViewIndex == 0 ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: _tabViewIndex == 0 ? MyTheme.colors.fontShaded : Colors.white,
                          fontSize: 18,
                          fontWeight: _tabViewIndex == 0 ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    _tabViewIndex = 0;
                    _googleText = 'Sign in with Google';
                  });
                },
              ),
            ),
            Expanded(
              child: GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    color: _tabViewIndex == 1 ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: _tabViewIndex == 1 ? MyTheme.colors.fontShaded : Colors.white,
                          fontSize: 18,
                          fontWeight: _tabViewIndex == 1 ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    _tabViewIndex = 1;
                    _googleText = 'Sign up with Google';
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getLoginButton(BuildContext context) {
    return Positioned(
      top: 150,
      child: Center(
        child: GestureDetector(
          child: Container(
            width: MediaQuery.of(context).size.width - 100,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  // colors: colors,
                  colors: <Color>[Theme.of(context).primaryColor, Colors.cyan],
                ),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Center(
                child: Text(
                  'LOGIN',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          onTap: () async {
            // Not using the form validator because its misaligning the error text
            // if (!_formKey.currentState.validate()) {
            //   return;
            // }
            _error = '';
            if (!emailRegex.hasMatch(_loginEmail)) {
              _error = 'Please enter a valid email address!';
            } else if (_loginPassword.length < minPasswordLen) {
              _error = 'Your password must be greater than ${minPasswordLen - 1} characters!';
            }

            if (_error.isNotEmpty) {
              _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(_error)));
              return;
            }

            // Input is good, try logging in
            try {
              setState(() {
                _error = '';
                loading = true;
              });
              dynamic result = await _authService.signInWithEmailAndPassword(_loginEmail, _loginPassword);

              if (result == null) {
                _error = 'There was an error signing in! Please try again.';
              }
            } on FirebaseAuthException catch (e) {
              switch (e.code) {
                case 'user-not-found':
                  _error = 'Wrong email or password! Please check your credentials and try again.';
                  break;
                case 'wrong-password':
                  _error = 'Wrong email or password! Please check your credentials and try again.';
                  break;
                default:
                  _error = 'There was an error signing in! Please try again.';
              }
            } catch (e) {
              _error = 'There was an unexpected error signing in: ${e.toString()}';
            }

            setState(() {
              loading = false;
            });

            if (_error.isNotEmpty) {
              _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(_error)));
              return;
            }
          },
        ),
      ),
    );
  }

  Widget getRegisterButton(BuildContext context) {
    return Positioned(
      top: 285,
      child: Center(
        child: GestureDetector(
          child: Container(
            width: MediaQuery.of(context).size.width - 100,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[Theme.of(context).primaryColor, Colors.cyan],
                ),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Center(
                child: Text(
                  'REGISTER',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          onTap: () async {
            _error = '';
            if (!emailRegex.hasMatch(_registerEmail)) {
              _error = 'Please enter a valid email address!';
            } else if (_registerPassword.length < minPasswordLen || _registerPassword.isEmpty) {
              _error = 'Your password must be greater than ${minPasswordLen - 1} characters!';
            } else if (_registerPassword2 != _registerPassword || _registerPassword2.isEmpty) {
              _error = 'Your passwords do not match!';
            }

            if (_error.isNotEmpty) {
              _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(_error)));
              return;
            }
            setState(() {
              loading = true;
            });

            dynamic result =
                await _authService.registerWithEmailAndPassword(_registerEmail, _registerPassword, _registerName);

            if (result == null) {
              _error = 'There was an error registering! Please try again.';
            } else if (result is FirebaseAuthException) {
              switch (result.code) {
                case 'email-already-in-use':
                  _error = 'This email is already in use by another user!';
                  break;
                default:
                  _error = 'There was an error signing in! Please try again.';
              }
            }

            setState(() {
              loading = false;
            });

            if (_error.isNotEmpty) {
              _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(_error)));
            }

            return;
          },
        ),
      ),
    );
  }

  void handleForgotPassword(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Reset password'),
          content: Container(
            height: 100.0,
            child: Column(
              children: <Widget>[
                Text('Enter the email that you used to create your account'),
                MyWidgets.sizeBox10,
                TextField(
                  decoration: InputDecoration(hintText: 'Email'),
                  onChanged: (value) {
                    setState(() {
                      _forgotEmail = value;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Send email'),
              onPressed: () async {
                // await _authService.resetPassword(_forgotEmail);

                setState(() {
                  _error =
                      'An email was sent to $_forgotEmail. Please follow the provided instructions to recover your password.';
                });

                Navigator.pop(context);
                if (_error.isNotEmpty) {
                  _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(_error)));
                  return;
                }
              },
            ),
          ],
        );
      },
    );
  }

  Widget googleSignInButton(BuildContext context, String action) {
    return FlatButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      color: Colors.white,
      textColor: Colors.grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(image: AssetImage("assets/images/google_logo.png"), height: 24.0),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              action,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
          )
        ],
      ),
      onPressed: () async {
        setState(() {
          _error = '';
          loading = true;
        });

        // try {
        //   dynamic result = await _authService.signInWithGoogle();
        //   loading = false;
        //   if (result == null) {
        //     _error = 'There was an error signing in with Google! Please check your internet connection and try again.';
        //   }
        // } catch (e) {
        //   _error = 'There was an error signing in with Google! Please check your internet connection and try again.';
        // }

        if (_error.isNotEmpty) {
          setState(() {
            loading = false;
          });
          _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(_error)));
          return;
        }
      },
    );
  }

  Widget getSocialLogin(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            child: Container(
              decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.asset('assets/google_small.png'),
              ),
            ),
            onTap: () {},
          ),
          Container(
            width: 55,
          ),
          GestureDetector(
            child: Container(
              decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.asset('assets/fb_small.png'),
              ),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
