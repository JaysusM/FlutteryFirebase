import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class login {

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

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

}