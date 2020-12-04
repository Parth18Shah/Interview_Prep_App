import 'package:flutter/material.dart';
import 'package:interview_prep/models/user.dart';
import 'package:interview_prep/resources/firebase_repository.dart';
import 'package:interview_prep/screens/authentication/sign_up_page.dart';
import 'package:interview_prep/screens/mentor/mentor_chat_screen.dart';
import 'package:interview_prep/screens/mentor/mentor_page.dart';
import 'package:interview_prep/utils/loading.dart';

class Wrapper extends StatelessWidget {

  FirebaseRepository _repository = FirebaseRepository();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: _repository.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active){
            User user = snapshot.data;
            if (user == null){
            print("=======No User===========");
              return  SignUpPage();
            }
print("=======user = ${user.email}=====");
            return MentorPage(currentUser : user);
          }else{
            return Loading();
          }

        }
    );
  }
}
