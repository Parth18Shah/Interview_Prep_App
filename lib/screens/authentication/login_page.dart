import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:interview_prep/resources/firebase_repository.dart';
import 'package:interview_prep/screens/authentication/sign_up_page.dart';
import 'package:interview_prep/utils/constants.dart';
import 'package:interview_prep/utils/dialog_box.dart';
import 'package:interview_prep/wrapper.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  FirebaseRepository _repository = FirebaseRepository();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _autoValidate = false;


  bool validateForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      return true;
    }
    return false;
  }

  void _submit() async{
    try{
      SystemChannels.textInput.invokeMethod("TextInput.hide");
      if (validateForm()) {
        String email = _emailController.text;
        String password = _passwordController.text;
        await _repository.signInUserWithEmailAndPassword(email, password);
        await showDialog(context: context, builder: (context) {
          return DialogBox(
            title: "Successfully Logged In",
            buttonText1: 'Ok',
            button1Func: () {
              Navigator.of(context).pop();
            },
            icon: Icons.check,
            description: "",

          );
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Wrapper(),
          ),
        );
        print("=======User Logged In========");
      }else {
        print("========Validation Error=========");
        setState(() {
          _autoValidate = true;
        });
      }
    }on FirebaseAuthException catch(e){
      print("=====${e.toString()}======");
      showDialog(context: context, builder: (context){
        return DialogBox(
          title: e.code,
          buttonText1: 'Ok',
          button1Func: (){
            Navigator.of(context).pop();
          },
          icon: Icons.clear,
          description: e.message,
          iconColor: Colors.red,
        );
      });
    }
  }
  Widget _buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Text(
            'Welcome!',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildEmailRow() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: _emailController,
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.email,
              color: mainColor,
            ),
            labelText: 'E-mail'),
        validator: MultiValidator([
          RequiredValidator(errorText: 'Email cannot be empty.'),
          EmailValidator(errorText: 'Invalid Email.'),
        ]),
      ),
    );
  }

  Widget _buildPasswordRow() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.text,
        obscureText: true,
        controller: _passwordController,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: mainColor,
          ),
          labelText: 'Password',
        ),
        validator: MultiValidator([
          RequiredValidator(errorText: 'This field cannot be empty.')
        ]),
      ),
    );
  }

  Widget _buildForgetPasswordButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        FlatButton(
          onPressed: () {},
          child: Text("Forgot Password"),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1.4 * (MediaQuery.of(context).size.height / 20),
          width: 5 * (MediaQuery.of(context).size.width / 10),
          margin: EdgeInsets.only(bottom: 20),
          child: RaisedButton(
            elevation: 5.0,
            color: mainColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            onPressed: _submit,
            child: Text(
              "Login",
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: MediaQuery.of(context).size.height / 40,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildOrRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: Text(
            '- OR -',
            style: TextStyle(
              fontWeight: FontWeight.w400,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildSocialBtnRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: mainColor,
            boxShadow: [
              BoxShadow(
                  color: Colors.black26, offset: Offset(0, 2), blurRadius: 6.0)
            ],
          ),
          child: Icon(
            FontAwesomeIcons.google,
            color: Colors.white,
          ),
        ),
        // Container(
        //   height: 60,
        //   width: 60,
        //   decoration: BoxDecoration(
        //     shape: BoxShape.circle,
        //     color: mainColor,
        //     boxShadow: [
        //       BoxShadow(
        //           color: Colors.black26, offset: Offset(0, 2), blurRadius: 6.0)
        //     ],
        //   ),
        //   child: Icon(
        //     FontAwesomeIcons.facebook,
        //     color: Colors.white,
        //   ),
        // ),
        // Container(
        //   height: 60,
        //   width: 60,
        //   decoration: BoxDecoration(
        //     shape: BoxShape.circle,
        //     color: mainColor,
        //     boxShadow: [
        //       BoxShadow(
        //           color: Colors.black26, offset: Offset(0, 2), blurRadius: 6.0)
        //     ],
        //   ),
        //   child: Icon(
        //     FontAwesomeIcons.twitter,
        //     color: Colors.white,
        //   ),
        // ),
      ],
    );
  }

  Widget _buildContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "Login",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 30,
                        color: mainColor,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpPage(),
                          ),
                        );
                      },
                      child: Text(
                        "Signup",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height / 30,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ],
                ),
                _buildEmailRow(),
                _buildPasswordRow(),
                _buildLoginButton(),
                _buildOrRow(),
                _buildSocialBtnRow(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xfff2f3f7),
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  // decoration: BoxDecoration(
                  color: mainColor,
                  // ),
                ),
              ),
              Form(
                key: _formKey,
                autovalidate: _autoValidate,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildLogo(),
                    _buildContainer(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
