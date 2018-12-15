import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'message.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class ChatScreen extends StatefulWidget {
  FirebaseUser _user;

  ChatScreen(this._user);

  createState() => new ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  TextEditingController _textEditingController = TextEditingController();
  FirebaseDatabase _database = FirebaseDatabase.instance;
  List<Message> _messages = List();
  DatabaseReference _ref;

  @override
  void initState() {
    super.initState();
    _ref = _database.reference().child("messages");
    _ref.onChildAdded.listen((event) {
      this.setState(() {
        _messages.add(Message.fromSnapshot(event.snapshot));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("General Chat"),
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          Expanded(
            flex: 9,
            child: Container(
              child: FirebaseAnimatedList(
                query: _ref,
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  Message message = Message.fromSnapshot(snapshot);
                  _messages.add(message);
                  return message.getWidget();
                },
              ),
              color: Colors.white,
            ),
          ),
          Expanded(
              flex: 1,
              child: Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: TextField(
                          controller: _textEditingController,
                          decoration: InputDecoration(
                            hintText: "Type your message",
                          ),
                        ),
                        margin: new EdgeInsets.symmetric(horizontal: 15.0),
                      ),
                      flex: 9,
                    ),
                    Expanded(
                        child: Container(child: IconButton(
                            icon: new Icon(Icons.send),
                            onPressed: _submitMessage),
                        padding: new EdgeInsets.only(right: 15.0),
                        ),
                        flex: 1)
                  ],
                ),
                decoration: new BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.black, width: 0.3))),
              ))
        ],
      )),
    );
  }

  _submitMessage() {
    this.setState(() {
      _messages.add(new Message(_textEditingController.text,
          widget._user.displayName, widget._user.photoUrl));
    });
    _textEditingController.text = "";
    _ref.push().set(_messages.last.toJson());
  }
}
