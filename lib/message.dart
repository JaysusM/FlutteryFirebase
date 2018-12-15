import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Message {
  String _key, _content, _username, _userProfilePicUrl;

  Message(this._content, this._username, this._userProfilePicUrl);

  Message.fromSnapshot(DataSnapshot snapshot)
      : _key = snapshot.key,
        _content = snapshot.value["content"],
        _username = snapshot.value["username"],
        _userProfilePicUrl = snapshot.value["userProfilePicUrl"];

  toJson() {
    return {
      "content": _content,
      "username": _username,
      "userProfilePicUrl": _userProfilePicUrl
    };
  }

  get userProfilePicUrl => _userProfilePicUrl;

  set userProfilePicUrl(value) {
    _userProfilePicUrl = value;
  }

  get username => _username;

  set username(value) {
    _username = value;
  }

  get content => _content;

  set content(value) {
    _content = value;
  }

  String get key => _key;

  set key(String value) {
    _key = value;
  }

  Widget getWidget() {
    return Container(child: ListTile(
      leading: new CircleAvatar(
        child: new Image.network(this.userProfilePicUrl),
      ),
      title: Text(content),
      subtitle: Text(username),
    ),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.black, width: 0.2))
    ),
    );
  }

}
