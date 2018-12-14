import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class loggedScreen extends StatelessWidget {
  FirebaseUser _user;

  loggedScreen(this._user) : assert(_user != null);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          automaticallyImplyLeading: false,
          title: new Text("You're logged in!"),
        ),
        body: new Center(
            child: new Column(
          children: <Widget>[
            new Text("\nHi ${_user.displayName}!",
                style: new TextStyle(fontSize: 20.0)),
            new Text("(${_user.email})"),
            new Container(
              child: (!_user.photoUrl.isNotEmpty)
                  ? new Image.network(_user.photoUrl)
                  : new Container(child: new Image.asset("assets/anonymous.png", fit: BoxFit.fill), height: 96.0, width: 96.0),
              margin: new EdgeInsets.all(25.0),
            ),
            new SizedBox(
              child: new OutlineButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pop(context);
                },
                child: new Stack(children: <Widget>[
                  new Positioned(
                      child: new Text("Log out",
                          style: new TextStyle(fontSize: 20.0)),
                      left: 12.5),
                  new Positioned(
                      child: new Image.asset("assets/exit.png", scale: 30.0),
                      right: 10.0),
                ], alignment: AlignmentDirectional.center),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                ),
                color: Colors.white,
              ),
              width: 170.0,
              height: 50.0,
            ),
          ],
        )));
  }
}
