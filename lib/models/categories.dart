import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Categories {
  final String name;
  // final String question;
  // final String answer;

  Categories({
    @required this.name,
    // @required this.question,
    // @required this.answer,
  });

  factory Categories.fromMap(Map<String, dynamic> data) {
    return Categories(
      name: data["name"],
      // question: data["question"],
      // answer: data["answer"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": this.name,
      // "question": this.question,
      // "answer": this.answer,
    };
  }
}
