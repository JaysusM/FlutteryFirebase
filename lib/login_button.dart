import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'logged_screen.dart';

class loginButton extends StatelessWidget {
  Function _getUser;
  String _imageLocation, _buttonText;

  loginButton(this._buttonText, this._getUser, this._imageLocation)
      : assert(_getUser != null),
        assert(_buttonText.isNotEmpty),
        assert(_imageLocation.isNotEmpty);

  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      child: new OutlineButton(
        onPressed: () async {
          FirebaseUser loadedUser = await _getUser();
          if(loadedUser != null)
            Navigator.push(context, MaterialPageRoute(builder: (context) => loggedScreen(loadedUser)));
        },
        child: new Stack(children: <Widget>[
          new Positioned(
              child:
                  new Text(_buttonText, style: new TextStyle(fontSize: 20.0)),
              left: 12.5),
          new Positioned(
              child: new Image.asset(_imageLocation, scale: 15.0), right: 10.0),
        ], alignment: AlignmentDirectional.center),
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(25.0),
        ),
        color: Colors.white,
      ),
      width: 200.0,
      height: 50.0,
    );
  }
}
