import 'package:chat/constraints.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String sender;
  final bool isMe;
  const MessageBubble(
      {required this.message, required this.sender, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        // sent by sender:
        isMe
            ? Padding(
                padding: EdgeInsets.only(right: 10),
                child: Text(
                  sender,
                  style: TextStyle(color: Colors.white, fontSize: 12.0),
                ),
              )
            : Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  sender,
                  style: TextStyle(color: Colors.grey[200], fontSize: 13.0),
                ),
              ),
        // message
        Padding(
          padding: EdgeInsets.only(bottom: 15, top: 3, left: 10, right: 10),
          child: Container(
            padding: EdgeInsets.all(13),
            decoration: BoxDecoration(
                color: isMe ? Colors.teal[200] : Colors.green[200],
                borderRadius:
                    isMe ? kSenderMessageBubble : kReceiverMessageBubble),
            child: Text(
              message,
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),
        )
      ],
    );
  }
}
