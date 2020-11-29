import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dbms/global.dart';
import 'package:dbms/home.dart';
import 'package:dbms/infopage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class facmark extends StatefulWidget {
  final int value;
  facmark({Key key, this.value}) : super(key: key);
  @override
  _facmarkState createState() => _facmarkState();
}

class _facmarkState extends State<facmark> {
  
  var firebaseUser =  FirebaseAuth.instance.currentUser;


  Widget buildUserList(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasData) {
        return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
                DocumentSnapshot user = snapshot.data.docs[index];
                return Container(
                  alignment: Alignment.topLeft,
                  //color: colors[index],
                  child: Column(
                    children: [
                    Text("$firebaseUser.uid : ${user.data()['$firebaseUser.uid']}",
                      style: TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  ),
                );
            },
        );
    } else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData){
        // Handle no data
        return Center(
            child: Text("No users found."),
        );
    } else {
        // Still loading
        return CircularProgressIndicator();
    }
}

  @override
  Widget build(BuildContext context) {
        

    return Scaffold(

     appBar : AppBar(
        centerTitle: true,
        title: Text("EXAM REPORT"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
              Colors.purple,
              Colors.purple
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
    stream: FirebaseFirestore.instance.collection("exams").doc("${widget.value}").collection("marklist").snapshots(),
    builder: buildUserList,
  ),
    );
  }
}