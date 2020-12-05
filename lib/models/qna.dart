import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class QnA {
  // final String name;
  final String id;
  final String question;
  final String answer;

  QnA({
    // @required this.name,
    @required this.id,
    @required this.question,
    @required this.answer,
  });

  factory QnA.fromMap(Map<String, dynamic> data) {
    return QnA(
      id: data["id"],
      question: data["question"],
      answer: data["answer"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "question": this.question,
      "answer": this.answer,
    };
  }
}
