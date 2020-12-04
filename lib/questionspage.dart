import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutteria/questions.dart';

class QuestionsPage extends StatefulWidget {
  @override
  _QuestionsPageState createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
                child: Icon(Icons.arrow_back_ios),
                onTap: () {
                  Navigator.of(context).pop();
                }),
            title: Text('Questions'),
            centerTitle: true,
            automaticallyImplyLeading: true,
            actions: [Padding(padding: EdgeInsets.all(8))],
            backgroundColor: Colors.red,
          ),
          body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.white, Colors.grey])),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              physics: AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Questions(width: width, height: height, index: index);
              },
            ),
          )),
    );
  }
}
