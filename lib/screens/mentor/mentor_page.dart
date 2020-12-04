import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interview_prep/models/user.dart';
import 'package:interview_prep/resources/firebase_repository.dart';
import 'package:interview_prep/screens/mentor/mentor_chat_screen.dart';
import 'package:interview_prep/screens/mentor/mentor_profile_page.dart';
import 'package:interview_prep/screens/mentor/mentor_tile.dart';
import 'package:interview_prep/utils/constants.dart';
import 'package:interview_prep/utils/loading.dart';

class MentorPage extends StatefulWidget {
  final User currentUser;
  MentorPage({this.currentUser});

  @override
  _MentorPageState createState() => _MentorPageState();
}

class _MentorPageState extends State<MentorPage> {
  FirebaseRepository _repository = FirebaseRepository();
  bool loading = true;
  User user;
  bool isMentor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUserDetails();
  }

  Future<void> getCurrentUserDetails() async {
    try {
      print("Is Mentor = $isMentor");
      setState(() {
        loading = true;
      });

      User getUser =
          await _repository.getCurrentUserDetails(widget.currentUser.email);
      setState(() {
        user = getUser;
        loading = false;
        isMentor = user.isMentor;
      });
      print("Is Mentor = $isMentor");
    } catch (err) {
      print(err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return loading
        ? Loading()
        : isMentor == true
            ? _buildScreenForMentor(height, width)
            : _buildScreenForNonMentor(height, width);
  }

  _buildScreenForNonMentor(final height, final width) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Container(
                    width: width * 0.6,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.perm_identity,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Mentors',
                            style: TextStyle(
                              fontFamily: 'Robo-semibold-italic',
                              color: Colors.grey,
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                StreamBuilder<List<User>>(
                    stream: _repository.getAllUsers(),
                    initialData: [],
                    builder: (context, snapshot) {
                      List<User> users = snapshot.data;
                      List<User> mentor = [];
                      for (int ind = 0; ind < users.length; ind++) {
                        if ((users[ind].isMentor == true) &&
                            (widget.currentUser.email != users[ind].email)) {
                          mentor.add(users[ind]);
                        }
                      }
                      return mentor.length == 0
                          ? Container(
                              height: height - 100,
                              child: Center(
                                child: Text(
                                  'No Chats',
                                  style: TextStyle(
                                      fontSize: 35,
                                      fontFamily: 'Gilroy-bold',
                                      color: Colors.black.withOpacity(0.4)),
                                ),
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: mentor.length,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return MentorTile(
                                    currentUser: user,
                                    width: width,
                                    height: height,
                                    index: index,
                                    mentor: mentor[index]);
                              },
                            );
                    }),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: mainColor,
        child: Icon(
          Icons.exit_to_app,
          color: Colors.white,
        ),
        onPressed: () async {
          await _repository.logout();
        },
      ),
    );
  }

  _buildScreenForMentor(final height, final width) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Container(
                    width: width * 0.6,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.perm_identity,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Mentors',
                            style: TextStyle(
                              fontFamily: 'Robo-semibold-italic',
                              color: Colors.grey,
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                StreamBuilder<List<User>>(
                    stream: _repository.chatListForMentors(user.email),
                    initialData: [],
                    builder: (context, snapshot) {
                      List<User> users = snapshot.data;
                      print("users = $users");
                      List<User> mentor = [];
                      for (int ind = 0; ind < users.length; ind++) {
                         mentor.add(users[ind]);
                      }
                      return mentor.length == 0
                          ? Container(
                              height: height - 100,
                              child: Center(
                                child: Text(
                                  'No Chats',
                                  style: TextStyle(
                                      fontSize: 35,
                                      fontFamily: 'Gilroy-bold',
                                      color: Colors.black.withOpacity(0.4)),
                                ),
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: mentor.length,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return MentorTile(
                                    currentUser: user,
                                    width: width,
                                    height: height,
                                    index: index,
                                    mentor: mentor[index]);
                              },
                            );
                    }),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: mainColor,
        child: Icon(
          Icons.exit_to_app,
          color: Colors.white,
        ),
        onPressed: () async {
          await _repository.logout();
        },
      ),
    );
  }
}
