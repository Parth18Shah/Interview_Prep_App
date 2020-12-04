import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutteria/questionspage.dart';

class Topics extends StatelessWidget {
  final width;
  final height;
  final index;
  Topics({this.width, this.height, this.index});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuestionsPage(),
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
              'Technical Based',
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
