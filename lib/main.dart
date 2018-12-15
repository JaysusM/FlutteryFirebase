import 'package:flutter/material.dart';
import 'login_button.dart';
import 'login.dart';

void main() => runApp(new HomeWidget());

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        accentColor: Colors.white,
        primaryColor: new Color(0xFF040477),
      ),
      home: new Scaffold(
          appBar: new AppBar(
            title: new Text("Firebase Auth")
          ),
          body: new Container(
            child: new Center(
                child: new Column(
              children: <Widget>[
                new loginButton("Google", Login.googleSignIn, "assets/google.png"),
                new loginButton("Facebook", Login.facebookSignIn, "assets/facebook.png"),
                new loginButton("Anonymous", Login.anonymousSignIn, "assets/anonymous.png")
              ],
            )),
            padding: new EdgeInsets.symmetric(vertical: 30.0, horizontal: 15.0)
          ),
        backgroundColor: Colors.white
      ),
    );
  }
}
