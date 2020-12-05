import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:interview_prep/screens/homepage/answers.dart';
import 'package:interview_prep/models/qna.dart';

class Questions extends StatelessWidget {
  final width;
  final height;
  QnA record;
  Questions({this.width, this.height, this.record});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Answers(record: record),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(12.0),
        height: width * 0.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.red[200],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 60.0,
            ),
            Text(
              '${record.question}',
              style: TextStyle(
                fontFamily: 'Robo-medium',
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(
              width: 80.0,
            ),
            Icon(
              Icons.arrow_forward,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
