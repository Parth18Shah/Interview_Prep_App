import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:interview_prep/models/qna.dart';
import 'package:interview_prep/screens/homepage/questions.dart';
import 'package:interview_prep/screens/homepage/addQnA.dart';
import 'package:interview_prep/resources/firebase_methods.dart';

class QuestionsPage extends StatefulWidget {
  final name;
  QuestionsPage({this.name});

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
          backgroundColor: Colors.blue,
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Colors.grey])),
          child: StreamBuilder<List<QnA>>(
              stream: FirebaseMethods().getAllQuestions(widget.name),
              initialData: [],
              builder: (context, snapshot) {
                List<QnA> allrecords = snapshot.data;
                print(allrecords);
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: allrecords.length,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Questions(
                        width: width,
                        height: height,
                        record: allrecords[index]);
                  },
                );
              }),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Colors.green,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => addQnA(name: widget.name),
                ),
              );
            }),
      ),
    );
  }
}
