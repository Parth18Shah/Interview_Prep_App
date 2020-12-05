import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:interview_prep/models/categories.dart';
import 'package:interview_prep/screens/homepage/questionspage.dart';

class Topics extends StatelessWidget {
  final width;
  final height;
  Categories category;
  Topics({this.width, this.height, this.category});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuestionsPage(name: category.name),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(12.0),
        height: width * 0.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.red[100],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.computer,
              color: Colors.black,
            ),
            SizedBox(
              width: 12.0,
            ),
            Text(
              '${category.name}',
              style: TextStyle(
                fontFamily: 'Robo-semibold-italic',
                color: Colors.blue[900],
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
