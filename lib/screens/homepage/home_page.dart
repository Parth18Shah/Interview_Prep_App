import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:interview_prep/models/user.dart';
import 'package:interview_prep/models/categories.dart';
import 'package:interview_prep/resources/firebase_methods.dart';
import 'package:interview_prep/resources/firebase_repository.dart';
import 'package:interview_prep/screens/homepage/topics.dart';
import 'package:interview_prep/screens/homepage/addCategories.dart';
import 'package:interview_prep/screens/mentor/mentor_page.dart';
import 'package:interview_prep/utils/loading.dart';

class HomePage extends StatefulWidget {
  final User currentUser;
  HomePage({this.currentUser});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseRepository _repository = FirebaseRepository();
  bool loading = true;
  User user;
  bool isMentor;
  int currentindex = 0;

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

  logout() async {
    try {
      await FirebaseMethods().logout();
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
        : Scaffold(
            backgroundColor: Colors.white,
            body: currentindex == 0
                ? buildHomePage(height, width)
                : currentindex == 1 ? MentorPage(currentUser: user) : logout(),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                backgroundColor: Colors.green,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => addCategories(),
                    ),
                  );
                }),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: currentindex,
              onTap: (value) {
                setState(() {
                  currentindex = value;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: new Icon(Icons.home,
                      color: currentindex == 0 ? Colors.blue : Colors.grey),
                  title: new Text('Home'),
                ),
                BottomNavigationBarItem(
                  icon: new Icon(Icons.message,
                      color: currentindex == 1 ? Colors.blue : Colors.grey),
                  title: new Text('Chat'),
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.exit_to_app,
                        color: currentindex == 2 ? Colors.blue : Colors.grey),
                    title: Text('Logout')),
              ],
            ),
          );
  }

  SafeArea buildHomePage(double height, double width) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: height * 0.3,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment(0.9, 1.0),
                    colors: [Colors.blue[500], Colors.lightBlue[200]],
                  )),
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 10, right: 10),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Search for a particular topic!',
                                  style: TextStyle(
                                    fontFamily: 'Robo-semibold-italic',
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 60, left: 20, right: 10),
                        child: Container(
                          child: Text(
                            'Welcome back ${user.username}!',
                            style: TextStyle(
                              fontFamily: 'Robo-semibold-italic',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Column(
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    height: 100,
                    width: 600,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment(0.3, 5.0),
                          colors: [
                            const Color(0xffdd2c00),
                            const Color(0xffff9e80)
                          ],
                        )),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Start preparing for your interview',
                            style: TextStyle(
                              fontFamily: 'Robo-semibold-italic',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 50, left: 10),
                          child: Container(
                            padding: EdgeInsets.all(7.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.redAccent[700],
                            ),
                            child: Text(
                              'Choose one of the categories below',
                              style: TextStyle(
                                fontFamily: 'Robo-semibold-italic',
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    'Categories:',
                    style: TextStyle(
                      color: Colors.blue[900],
                      fontFamily: 'Robo-semibold-italic',
                      fontSize: 30,
                    ),
                  ),
                ),
                StreamBuilder<List<Categories>>(
                    stream: FirebaseMethods().getAllCategories(),
                    initialData: [],
                    builder: (context, snapshot) {
                      List<Categories> categories = snapshot.data;
                      print(categories);
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: categories.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Topics(
                              width: width,
                              height: height,
                              category: categories[index]);
                        },
                      );
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
