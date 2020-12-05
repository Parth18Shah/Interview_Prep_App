import 'package:flutter/foundation.dart';

class User {
  final String uid;
  final String username;
  final String email;
  final bool isAdmin;
  final bool isMentor;
  final String profession;
  final String about;
  final String age;
  final String state;
  final String country;

  User({
    @required this.uid,
    @required this.username,
    @required this.email,
    @required this.isAdmin,
    @required this.isMentor,
    @required this.profession,
    @required this.about,
    @required this.age,
    @required this.state,
    @required this.country,
  });

  Map<String, dynamic> toMap() {
    return {
      "uid": this.uid,
      "username": this.username,
      "email": this.email,
      "isAdmin": this.isAdmin,
      "isMentor": this.isMentor,
      "profession": this.profession,
      "state":  this.state,
      "country": this.country,
      "age": this.age,
      "about": this.about,
    };
  }

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      uid: data["uid"],
      username: data["username"],
      email: data["email"],
      isAdmin: data["isAdmin"],
      isMentor: data["isMentor"],
      profession: data["profession"],
      state: data["state"],
      country: data["country"],
      about: data["about"],
      age: data["age"],
    );
  }
}
