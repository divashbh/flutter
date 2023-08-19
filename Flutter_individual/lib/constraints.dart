import 'package:flutter/material.dart';

const MESSAGE_COLLECTION = "message";
const SENDER = "sender";
const MESSAGE_TEXT = "messageText";

const kSenderMessageBubble = BorderRadius.only(
  topLeft: Radius.circular(18),
  bottomLeft: Radius.circular(18),
  bottomRight: Radius.circular(18),
);

const kReceiverMessageBubble = BorderRadius.only(
  topRight: Radius.circular(18),
  bottomLeft: Radius.circular(18),
  bottomRight: Radius.circular(18),
);
