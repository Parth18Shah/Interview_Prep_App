import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:interview_prep/models/message.dart';
import 'package:interview_prep/models/user.dart';
import 'package:interview_prep/resources/firebase_repository.dart';
import 'package:interview_prep/screens/mentor/mentor_profile_page.dart';
import 'package:intl/intl.dart';

class MentorChatScreenPage extends StatefulWidget {
  final int index;
  final User currentUser;
  final User toUser;
  MentorChatScreenPage({this.index, this.currentUser, this.toUser});
  @override
  _MentorChatScreenPageState createState() => _MentorChatScreenPageState();
}

class _MentorChatScreenPageState extends State<MentorChatScreenPage> {
  final FirebaseRepository _repository = FirebaseRepository();
  TextEditingController _messageController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
        String textMessage = _messageController.text;
        Message message = Message(
          message: textMessage,
          toUid: widget.toUser.uid,
          toEmail: widget.toUser.email,
          fromUid: widget.currentUser.uid,
          fromEmail: widget.currentUser.email,
          timeOfMessage: DateTime.now(),
        );
        await _repository.storeMessage(message, widget.currentUser);
        _messageController.clear();
        print("============Message Stored==========");
      } else {
        setState(() {
          _autoValidate = true;
        });
      }
    } catch (err) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios),
        backgroundColor: Colors.white,
        elevation: 0,
        title: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MentorProfilePage(),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Hero(
                tag: "mentor${widget.index}",
                child: CircleAvatar(
                  backgroundImage: AssetImage('images/cillian.jpg'),
                ),
              ),
              SizedBox(width: 5),
              Text(
                '${widget.toUser.username}',
                style:
                    TextStyle(fontFamily: 'Gilroy-bold', color: Colors.black),
              ),
            ],
          ),
        ),
      ),
      body: StreamBuilder<List<Message>>(
          stream: _repository.getFromMessages(
              widget.currentUser.email, widget.toUser.email),
          initialData: [],
          builder: (context, snapshot) {
            List<Message> from = snapshot.data;
            print("from = $from");
            return StreamBuilder<List<Message>>(
                stream: _repository.getToMessages(
                    widget.currentUser.email, widget.toUser.email),
                initialData: [],
                builder: (context, snapshot) {
                  List<Message> to = snapshot.data;
                  print("to = $to");
                  List<Message> f = [];
                  f.addAll(from);
                  f.addAll(to);
                  f.sort((a, b) {
                    return b.timeOfMessage
                        .toIso8601String()
                        .compareTo(a.timeOfMessage.toIso8601String());
                  });
                  return ListView.builder(
                    itemCount: f.length,
                    reverse: true,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Bubble(
                          padding: BubbleEdges.all(13),
                          margin: BubbleEdges.only(top: 10),
                          alignment:
                              f[index].fromEmail == widget.currentUser.email
                                  ? Alignment.topRight
                                  : Alignment.topLeft,
                          nip: f[index].fromEmail == widget.currentUser.email
                              ? BubbleNip.rightTop
                              : BubbleNip.leftTop,
                          color: f[index].fromEmail == widget.currentUser.email
                              ? Colors.green
                              : Colors.white,
                          child: f[index].fromEmail == widget.currentUser.email
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${f[index].message}',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontFamily: 'Gilroy',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 7),
                                    Text(
                                      '${DateFormat("hh:mm:aa").format(f[index].timeOfMessage)} / ${DateFormat('dd/MM/yyyy').format(f[index].timeOfMessage)}',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontFamily: 'Robo-light',
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${f[index].message}',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: 'Gilroy',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 7),
                                    Text(
                                      '${DateFormat("hh:mm:aa").format(f[index].timeOfMessage)} / ${DateFormat('dd/MM/yyyy').format(f[index].timeOfMessage)}',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: 'Robo-light',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      );
                    },
                  );
                });
          }),
      bottomNavigationBar: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Form(
          key: _formKey,
          autovalidate: _autoValidate,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 9,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Message',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 2,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.grey[300],
                    ),
                    validator: MultiValidator(
                        [RequiredValidator(errorText: 'Cannot be empty.')]),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  child: Icon(
                    Icons.send,
                    color: Colors.black,
                    size: 28,
                  ),
                  onTap: () => onSubmit(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
