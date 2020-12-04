import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutteria/topics.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
                      colors: [
                        const Color(0xffee0000),
                        const Color(0xffffcdd2)
                      ],
                    )),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 10, right: 10),
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
                          padding: const EdgeInsets.only(
                              top: 60, left: 20, right: 10),
                          child: Container(
                            child: Text(
                              'Welcome back UserName!',
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
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: 5,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Topics(width: width, height: height, index: index);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.mail),
            title: new Text('Messages'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('Profile')),
        ],
      ),
    );
  }
}
