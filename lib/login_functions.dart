import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class login {

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FacebookLogin _facebookLogin = FacebookLogin();

  static Future<FirebaseUser> googleSignIn() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    if(googleUser != null) {
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      return await _auth.signInWithGoogle(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken
      );
    }
    return null;
  }

  static Future<FirebaseUser> anonymousSignIn() async {
    return _auth.signInAnonymously();
  }

  static Future<FirebaseUser> facebookSignIn() async {
    FacebookLoginResult result = await _facebookLogin.logInWithReadPermissions(['email']);
    if(result.status == FacebookLoginStatus.loggedIn)
      return _auth.signInWithFacebook(accessToken: result.accessToken.token);
    return null;
  }

}