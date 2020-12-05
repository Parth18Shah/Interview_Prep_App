import 'package:flutter/material.dart';

class MentorProfilePage extends StatelessWidget {
  final index;
  final mentor;
  MentorProfilePage({this.index, this.mentor});
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              Container(
                height: height,
                width: width * 0.7,
                color: Colors.blue[100],
              ),
              Container(
                height: height,
                width: width * 0.3,
                color: Colors.white,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: width * 0.4,
                  height: width * 0.6,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('images/cillian.jpg'),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      '${mentor["username"].toString().split(" ")[0]}',
                      style: TextStyle(
                        fontFamily: 'Gilroy-bold',
                        fontSize: 45,
                        color: Color(0xFF4044AA),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      '${mentor["username"].toString().split(" ")[1][0]}',
                      style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 45,
                        color: Color(0xFF4044AA),
                      ),
                    ),
                  ],
                ),
                Text(
                  '${mentor["age"]} years, ${mentor["state"]}, ${mentor["country"]}',
                  style: TextStyle(
                    fontFamily: 'Robo-light',
                    fontSize: 12,
                    color: Color(0xFF4044AA),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Profession',
                  style: TextStyle(
                    fontFamily: 'Robo-light',
                    fontSize: 30,
                    color: Color(0xFF4044AA),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '${mentor["profession"]}',
                  style: TextStyle(
                    fontFamily: 'Robo-light',
                    fontSize: 20,
                    color: Color(0xFF4044AA),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'About',
                  style: TextStyle(
                    fontFamily: 'Robo-light',
                    fontSize: 30,
                    color: Color(0xFF4044AA),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  width: width * 0.9,
                  child: Text(
                    '${mentor["about"]}',
                    style: TextStyle(
                      fontFamily: 'Robo-light',
                      fontSize: 20,
                      color: Color(0xFF4044AA),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
