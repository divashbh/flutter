import 'package:chat/login.dart';
import 'package:chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'constraints.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseDB = FirebaseFirestore.instance;
  late User loggedInUser;

  getCurrentlyLoggedInUser() {
    loggedInUser = firebaseAuth.currentUser!;
    print(loggedInUser.email);
  }

  @override
  void initState() {
    getCurrentlyLoggedInUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[900],
        title: Text(loggedInUser.email!),
        actions: [
          IconButton(
              onPressed: () {
                showMyAlertDialog(context);
              },
              icon: Icon(Icons.close))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/background.jpg"),
                    fit: BoxFit.cover),
              ),
              child: StreamBuilder(
                stream: firebaseDB.collection(MESSAGE_COLLECTION).snapshots(),
                builder: (BuildContext context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    final listMessageQS = snapshot.data!.docs.reversed;
                    List<MessageBubble> messageBubbleList = <MessageBubble>[];
                    for (var singleMessageData in listMessageQS) {
                      final message = singleMessageData.data();
                      MessageBubble mb = MessageBubble(
                          message: message[MESSAGE_TEXT],
                          sender: message[SENDER],
                          isMe: message[SENDER] == loggedInUser.email);
                      messageBubbleList.add(mb);
                      print("The message is ${message}");
                    }
                    return ListView(
                      reverse: true,
                      children: messageBubbleList,
                    );
                  }
                },
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(color: Colors.cyan.shade900, width: 2))),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: messageController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        hintText: "Type your message here",
                        border: InputBorder.none),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      if (messageController.text.isNotEmpty) {
                        sendMessageToFirebase(messageController.text);
                      }
                      messageController.clear();
                    },
                    icon: Icon(
                      Icons.send,
                      color: Colors.cyan[900],
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  void logOut() {
    firebaseAuth.signOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
    showFlutterToast();
  }

  void sendMessageToFirebase(String typedMessageText) {
    // {messageText: Hello, sender: flutter@gmail.com}
    final Map<String, dynamic> messageData = <String, dynamic>{
      SENDER: loggedInUser.email,
      MESSAGE_TEXT: typedMessageText
    };
    firebaseDB.collection(MESSAGE_COLLECTION).add(messageData);
  }

  void showMyAlertDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              icon: Icon(
                Icons.power_settings_new,
                color: Colors.red,
              ),
              title: Text("Nepali Chat"),
              content: Text("Are you sure to logout?"),
              actions: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                  onPressed: () {
                    logOut();
                  },
                  child: Text(
                    "Ok",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ));
  }

  void showFlutterToast() {
    Fluttertoast.showToast(
      msg: "Log out Successful",
      toastLength: Toast.LENGTH_LONG,
      // gravity: ToastGravity.TOP,
    );
  }
}
