import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

class Storage {

  static final FirebaseStorage storage = FirebaseStorage();
  
  static Future<bool> uploadFile(FirebaseUser user) async {
    File file = await ImagePicker.pickImage(source: ImageSource.gallery);
    if(file != null) {
      try {
        StorageReference ref = storage.ref().child("user")
            .child(user.uid)
            .child(file.path
            .split("/")
            .last);
        ref.putFile(file);
        return true;
      } catch(e) {
        return false;
      }
    }
    return false;
  }

}