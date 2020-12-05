import 'package:flutter/material.dart';
import 'package:interview_prep/models/user.dart';
import 'package:interview_prep/screens/mentor/mentor_chat_screen.dart';

import 'mentor_profile_page.dart';

class MentorTile extends StatelessWidget {
  final width;
  final height;
  final index;
  final User mentor;
  final User currentUser;
  MentorTile(
      {this.width, this.height, this.index, this.mentor, this.currentUser});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MentorChatScreenPage(
              index: index,
              currentUser: currentUser,
              toUser: mentor,
            ),
          ),
        ); 
      },
      child: Container(
        height: width * 0.3,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap:mentor.isMentor != true ? (){} : () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MentorProfilePage(mentor: mentor, index: index),
                  ),
                );
              },
              child: Hero(
                tag: "mentor-$index",
                              child: CircleAvatar(
                  backgroundImage: AssetImage('images/acc.png'),
                  radius: 45,
                ),
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${mentor.username}',
                  style: TextStyle(
                    fontFamily: 'Robo-light',
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '${mentor.profession}',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontFamily: 'Robo-light',
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            SizedBox(width: 20),
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Text(
                '',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontFamily: 'Robo-light',
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
