import 'package:interview_prep/models/message.dart';
import 'package:interview_prep/models/user.dart';
import 'package:interview_prep/resources/firebase_methods.dart';

class FirebaseRepository {
  FirebaseMethods _firebaseMethods = FirebaseMethods();

  Future<User> createAccountWithEmailAndPassword(
          String email, String password, String username) =>
      _firebaseMethods.createAccountWithEmailAndPassword(
          email, password, username);

  Future<User> signInUserWithEmailAndPassword(String email, String password) =>
      _firebaseMethods.signInUserWithEmailAndPassword(email, password);

  Future<void> logout() => _firebaseMethods.logout();

  Stream<User> get onAuthStateChanged => _firebaseMethods.onAuthStateChanged;

  Stream<List<User>> getAllUsers() => _firebaseMethods.getAllUsers();

  Stream<List<User>> chatListForMentors(String email) => _firebaseMethods.chatListForMentors(email);

  Stream<List<Message>> getFromMessages(String fromEmail, String toEmail) => _firebaseMethods.getFromMessages(fromEmail, toEmail);

  Stream<List<Message>> getToMessages(String fromEmail, String toEmail) => _firebaseMethods.getToMessages(fromEmail, toEmail);

  Future<User> getCurrentUserDetails(String email) => _firebaseMethods.getCurrentUserDetails(email);

  Future<void> storeMessage(Message message, User user) => _firebaseMethods.storeMessage(message, user);
}
