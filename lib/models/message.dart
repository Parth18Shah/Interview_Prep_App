import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Message {
  final String message;
  final DateTime timeOfMessage;
  final String fromUid;
  final String toUid;
  final String fromEmail;
  final String toEmail;

  Message({
    @required this.message,
    @required this.timeOfMessage,
    @required this.fromUid,
    @required this.toUid,
    @required this.fromEmail,
    @required this.toEmail,
  });

  factory Message.fromMap(Map<String, dynamic> data) {
    return Message(
      message: data["message"],
      timeOfMessage: DateTime.fromMillisecondsSinceEpoch(
          (data["timeOfMessage"] as Timestamp).millisecondsSinceEpoch),
      fromUid: data["fromUid"],
      toUid: data["toUid"],
      fromEmail: data["fromEmail"],
      toEmail: data["toEmail"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "message": this.message,
      "timeOfMessage": this.timeOfMessage,
      "fromUid": this.fromUid,
      "toUid": this.toUid,
      "fromEmail": this.fromEmail,
      "toEmail": this.toEmail,
    };
  }
}
