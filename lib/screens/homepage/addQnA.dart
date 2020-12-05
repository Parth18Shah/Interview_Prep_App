import 'package:flutter/material.dart';
import 'package:interview_prep/models/qna.dart';
import 'package:interview_prep/resources/firebase_repository.dart';
import 'package:interview_prep/models/categories.dart';
import 'package:form_field_validator/form_field_validator.dart';

class addQnA extends StatefulWidget {
  final name;
  addQnA({this.name});

  @override
  _addQnAState createState() => _addQnAState();
}

class _addQnAState extends State<addQnA> {
  final FirebaseRepository _repository = FirebaseRepository();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _questionController = TextEditingController();
  TextEditingController _answerController = TextEditingController();
  bool _autoValidate = false;

  bool validateForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      return true;
    }
    return false;
  }

  Future<void> onSubmit() async {
    try {
      if (validateForm()) {
        String question = _questionController.text;
        String answer = _answerController.text;
        QnA record = QnA(
          question: question,
          answer: answer,
          id: DateTime.now().toIso8601String(),
        );
        await _repository.storeQnA(record, widget.name);
        _questionController.clear();
        _answerController.clear();
        print("============Message Stored==========");
        Navigator.of(context).pop();
      } else {
        setState(() {
          _autoValidate = true;
        });
      }
    } catch (err) {}
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              child: Icon(Icons.arrow_back_ios),
              onTap: () {
                Navigator.of(context).pop();
              }),
          title: Text('Add a question and its answer for ${widget.name}.'),
        ),
        body: Form(
          key: _formKey,
          autovalidate: _autoValidate,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter the question:',
                style: TextStyle(
                  fontFamily: 'Robo-semibold-italic',
                  color: Colors.grey,
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                ),
              ),
              TextFormField(
                  controller: _questionController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter the question';
                    }
                    return null;
                  }),
              SizedBox(
                height: 20,
              ),
              Text(
                'Enter the answer for the above question:',
                style: TextStyle(
                  fontFamily: 'Robo-semibold-italic',
                  color: Colors.grey,
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                ),
              ),
              TextFormField(
                  controller: _answerController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter it's answer";
                    }
                    return null;
                  }),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton(
                  onPressed: () {
                    // // Validate returns true if the form is valid, or false
                    // // otherwise.
                    // if (_formKey.currentState.validate()) {
                    //   // If the form is valid, display a Snackbar.
                    //   Scaffold.of(context).showSnackBar(
                    //       SnackBar(content: Text('Processing Data')));
                    // }
                    onSubmit();
                  },
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
