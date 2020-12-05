import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:interview_prep/models/qna.dart';

class Answers extends StatefulWidget {
  QnA record;
  Answers({this.record});
  @override
  _AnswersState createState() => _AnswersState();
}

class _AnswersState extends State<Answers> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
                child: Icon(Icons.arrow_back_ios),
                onTap: () {
                  Navigator.of(context).pop();
                }),
            title: Text('Answers'),
            centerTitle: true,
            actions: [Padding(padding: EdgeInsets.all(8))],
            backgroundColor: Colors.red,
          ),
          body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.white, Colors.grey])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 300,
                  width: 700,
                  margin: EdgeInsets.all(30.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.red[200],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 40.0, left: 15.0, right: 5.0),
                    child: Text(
                      '${widget.record.question}',
                      style: TextStyle(
                        fontFamily: 'Robo-medium',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  '${widget.record.answer}',
                  style: TextStyle(
                    fontFamily: 'Robo-medium',
                    color: Colors.blue[900],
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                )
              ],
            ),
          )),
    );
  }
}
