import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'storage.dart';
import 'chat_screen.dart';

class loggedScreen extends StatelessWidget {
  FirebaseUser _user;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  loggedScreen(this._user) : assert(_user != null);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: scaffoldKey,
        appBar: new AppBar(
          automaticallyImplyLeading: false,
          title: new Text("You're logged in!"),
        ),
        body: new Center(
            child: new Column(
          children: <Widget>[
            new Text(
                "\nHi ${(_user.isAnonymous) ? "anonymous user" : _user.displayName}!",
                style: new TextStyle(fontSize: 20.0)),
            (_user.isAnonymous)
                ? new Container()
                : new Text("(${_user.email})"),
            new Container(
              child: (_user.photoUrl != null && _user.photoUrl.isNotEmpty)
                  ? new Container(
                      child: new FadeInImage(
                          placeholder: new AssetImage("assets/anonymous.png"),
                          image: new NetworkImage(_user.photoUrl)),
                      height: 48.0,
                      width: 48.0,
                    )
                  : new Container(
                      child: new Image.asset("assets/anonymous.png",
                          fit: BoxFit.fill),
                      height: 48.0,
                      width: 48.0),
              margin: new EdgeInsets.all(25.0),
            ),
            new Container(
              child: new SizedBox(
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
              margin: new EdgeInsets.only(bottom: 15.0),
            ),
            new Container(child: new SizedBox(
              child: new OutlineButton(
                onPressed: (_user.isAnonymous)
                    ? null
                    : () async {
                        scaffoldKey.currentState.showSnackBar(new SnackBar(
                            content: new Text("Uploading file...")));
                        bool success = await Storage.uploadFile(_user);
                        scaffoldKey.currentState.showSnackBar(new SnackBar(
                            content: new Text((success)
                                ? "Succesfully uploaded file"
                                : "Error trying to upload file")));
                      },
                child: new Stack(children: <Widget>[
                  new Positioned(
                      child: new Text("Upload File",
                          style: new TextStyle(fontSize: 20.0)),
                      left: 12.5),
                ], alignment: AlignmentDirectional.center),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                ),
                color: Colors.white,
              ),
              width: 170.0,
              height: 50.0,
            ),
            margin: new EdgeInsets.only(bottom: 15.0),
            ),
            new Container(
              child: new SizedBox(
                child: new OutlineButton(
                  onPressed: (_user.isAnonymous)
                      ? null
                      : () {
                          Navigator.push(context,
                              new MaterialPageRoute(builder: (context) {
                            return ChatScreen(_user);
                          }));
                        },
                  child: new Stack(children: <Widget>[
                    new Positioned(
                        child: new Text("Chat",
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
              margin: new EdgeInsets.only(bottom: 15.0),
            ),
          ],
        )));
  }
}
