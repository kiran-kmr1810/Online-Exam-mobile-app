import 'package:dbms/exam.dart';
import 'package:dbms/infopage.dart';
import 'package:dbms/quizpage.dart';
import 'package:dbms/quizpage.dart';
import 'package:dbms/resultpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/authentication_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

final firestoreInstance = FirebaseFirestore.instance;


class Studenthome extends StatefulWidget {

  @override
  _StudenthomeState createState() => _StudenthomeState();
}


class _StudenthomeState extends State<Studenthome> {

  int k;
  String starttime;
  String date ;
  String endtime;
  int state = 0;

Widget buildUserList(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasData) {
        return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
                DocumentSnapshot user = snapshot.data.docs[index];
                if(user.data()["date"]!=null){
                date = DateFormat.yMMMMd('en_US').format((user.data()["date"]).toDate());}
                //print(date);
                if(user.data()["start time"]!=null){
                 starttime = DateFormat.jm().format((user.data()['start time']).toDate());
                }
                if(user.data()["end time"]!=null){
                endtime = DateFormat.jm().format((user.data()['end time']).toDate());}
                k = user.data()["key"]; 
                return customcard(
                  user.data()["test name"] , 
                  user.data()["course code"] , 
                  date, 
                  starttime, 
                  endtime,
                  k,
              );
            },
        );
    } else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData){
        return Center(
            child: Text("No users found."),
        );
    } else {
        return Container(
          alignment: Alignment.center,
          height:10,
          width:10,
          child: CircularProgressIndicator()
          );
           
    }
}



Widget customcard(String testname , String coursecode , String date , String starttime , String endtime, int k){
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 30.0,
      ),
      child: InkWell(
        onTap: () {
                //Quiz();   
                print("$k") ;   
                /*await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Resultpage(marks: 10)),
        );*/  
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (_) => Quiz(value: k)));
        },
        child: Material(
          color: Colors.blueGrey[800],
          elevation: 10.0,
          borderRadius: BorderRadius.circular(25.0),
          child: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: Material(
                    child: Container(
                      child: Text("$coursecode"),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "$testname",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontFamily: "Quando",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "$date \n $starttime - $endtime",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontFamily: "Alike"
                    ),
                    maxLines: 5,
                    textAlign: TextAlign.justify,
                  ),
                  
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }







 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        centerTitle: true,
        title: Text(""),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
              Colors.blueGrey,
              Colors.black
            ]
          )          
         ),        
     ), 
    actions: <Widget>[
    Padding(
      padding: EdgeInsets.only(right: 20.0),
      child: GestureDetector(
        onTap: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Infopage()),
                );
        },
        child: Icon(
          Icons.person,
          size: 26.0,
        ),
      )
    ),
    Padding(
      padding: EdgeInsets.only(right: 20.0),
      child: GestureDetector(
        onTap: () {},
        child: Icon(
            Icons.settings
        ),
      )
    ),
  ],
),

  
  body: StreamBuilder(
    stream: FirebaseFirestore.instance.collection("exams").snapshots(),
    builder: buildUserList,
  ),
  
      
    );
  }



}
