import 'package:flutter/material.dart';
import 'package:interview_prep/resources/firebase_repository.dart';
import 'package:interview_prep/models/categories.dart';
import 'package:form_field_validator/form_field_validator.dart';

class addCategories extends StatefulWidget {
  @override
  _addCategoriesState createState() => _addCategoriesState();
}

class _addCategoriesState extends State<addCategories> {
  final FirebaseRepository _repository = FirebaseRepository();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
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
        String name = _nameController.text;
        Categories categName = Categories(
          name: name,
        );
        Scaffold.of(context).showSnackBar(
        SnackBar(content: Text('Processing Data')));
        await _repository.storeCategories(categName);
        _nameController.clear();
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
          title: Text('Add a category'),
        ),
        body: Form(
          key: _formKey,
          autovalidate: _autoValidate,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter the category name',
                style: TextStyle(
                  fontFamily: 'Robo-semibold-italic',
                  color: Colors.grey,
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                ),
              ),
              TextFormField(
                  controller: _nameController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter the category name';
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
