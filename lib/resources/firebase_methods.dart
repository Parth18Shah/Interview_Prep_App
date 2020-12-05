import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:interview_prep/models/message.dart';
import 'package:interview_prep/models/user.dart' as newUser;

import '../models/categories.dart';
import '../models/qna.dart';

class FirebaseMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static final firestore = FirebaseFirestore.instance;

  final bool isAdmin = false;
  final bool isMentor = false;
  final String profession = '';
  final String about = '';
  final String age = '';
  final String state = '';
  final String country = '';
  final String name = '';
  final String question = '';
  final String answer = '';

  newUser.User _userFromFirebase(User user) {
    return user != null ? newUser.User(uid: user.uid, email: user.email) : null;
  }

  Stream<newUser.User> get onAuthStateChanged {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  Stream<List<newUser.User>> getAllUsers() {
    return firestore.collection("Users/").snapshots().map((snap) =>
        snap.docs.map((doc) => newUser.User.fromMap(doc.data())).toList());
  }

  Stream<List<newUser.User>> chatListForMentors(String email) {
    return firestore.collection("Users/$email/from/").snapshots().map((snap) =>
        snap.docs.map((doc) => newUser.User.fromMap(doc.data())).toList());
  }

  Stream<List<Message>> getFromMessages(String fromEmail, String toEmail) {
    return firestore
        .collection("Users/$fromEmail/from/$toEmail/messages")
        .snapshots()
        .map((snap) =>
            snap.docs.map((doc) => Message.fromMap(doc.data())).toList());
  }

  Stream<List<Message>> getToMessages(String fromEmail, String toEmail) {
    print("Users/$toEmail/from/$fromEmail/messages/");
    return firestore
        .collection("Users/$toEmail/from/$fromEmail/messages/")
        .snapshots()
        .map((snap) => snap.docs.map((doc) {
              print(doc.data());
              return Message.fromMap(doc.data());
            }).toList());
  }

  Future<newUser.User> createAccountWithEmailAndPassword(
      String email, String password, String username) async {
    try {
      final authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      newUser.User user = newUser.User(
        uid: authResult.user.uid,
        email: email,
        username: username,
        isMentor: isMentor,
        isAdmin: isAdmin,
        country: country,
        profession: profession,
        state: state,
        age: age,
        about: about,
      );
      await firestore.doc("Users/$email").set(user.toMap());
      User authUser = authResult.user;
      return _userFromFirebase(authUser);
    } on FirebaseAuthException catch (err) {
      if (err.code == 'weak-password') {
        throw FirebaseAuthException(
            code: 'Weak Password',
            message: 'Password length should be at least 6 characters');
      } else if (err.code == 'invalid-email') {
        throw FirebaseAuthException(
            code: 'Invalid Email',
            message: 'The email address is badly formatted.');
      } else if (err.code == 'email-already-in-use') {
        throw FirebaseAuthException(
            code: 'Email Already exists', message: 'Login into the app');
      } else {
        throw FirebaseAuthException(
            code: 'Some error occured',
            message: 'Try again later or check your internet connection');
      }
    }
  }

  Future<newUser.User> signInUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = authResult.user;
      return _userFromFirebase(user);
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'weak-password') {
        throw FirebaseAuthException(
            code: 'Weak Password',
            message: 'Password length should be atleast 6 characters');
      } else if (e.code == 'wrong-password') {
        throw FirebaseAuthException(
            code: 'Wrong Password', message: 'The password is incorrect.');
      } else if (e.code == 'invalid-email') {
        throw FirebaseAuthException(
            code: 'Invalid Email',
            message: 'The email address is badly formatted');
      } else if (e.code == 'user-not-found') {
        throw FirebaseAuthException(
            code: 'User not Found',
            message:
                'There is no user record corresponding to this credentials, create an account');
      } else {
        throw FirebaseAuthException(
            code: 'Some error occured',
            message: 'Try again later or check your internet connection');
      }
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<newUser.User> getCurrentUserDetails(String email) async {
    return await firestore
        .doc("Users/$email")
        .get()
        .then((value) => newUser.User.fromMap(value.data()));
  }

  Future<void> storeMessage(Message message, newUser.User user) async {
    try {
      String path0 = "Users/${message.toEmail}/from/${message.fromEmail}/";
      await firestore.doc(path0).set(user.toMap());
      String path =
          "Users/${message.toEmail}/from/${message.fromEmail}/messages/${DateTime.now().toIso8601String()}";
      await firestore.doc(path).set(message.toMap());
    } catch (err) {
      print(err.toString());
    }
  }

  Stream<List<Categories>> getAllCategories() {
    return firestore.collection("Categories/").snapshots().map((snap) =>
        snap.docs.map((doc) => Categories.fromMap(doc.data())).toList());
  }

  Future<void> storeCategories(Categories categories) async {
    try {
      // String path0 = "Users/${message.toEmail}/from/${message.fromEmail}/";
      String path0 = "Categories/${categories.name}/";
      await firestore.doc(path0).set(categories.toMap());
    } catch (err) {
      print(err.toString());
    }
  }

  Stream<List<QnA>> getAllQuestions(String name) {
    return firestore.collection("Categories/$name/questions/").snapshots().map(
        (snap) => snap.docs.map((doc) => QnA.fromMap(doc.data())).toList());
  }

  Future<void> storeQnA(QnA qna, String categName) async {
    try {
      String path0 = "Categories/$categName/questions/${qna.id}";
      await firestore.doc(path0).set(qna.toMap());
    } catch (err) {
      print(err.toString());
    }
  }
}
