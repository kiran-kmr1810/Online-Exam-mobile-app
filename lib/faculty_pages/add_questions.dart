import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dbms/global.dart';
import 'package:dbms/home.dart';
import 'package:dbms/infopage.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:dbms/global.dart' as globals;

class Questions extends StatefulWidget {
  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {


  List colors = [Colors.brown, Colors.green, Colors.red];
  Random random = new Random();
  int index = 0;
  int c ;

  @override
  void initState() {
    print("init");
    firestoreInstance.collection("keys").doc("Krt05MBMjb9Ro6LIMEhf").get().then((value){
      setState(() {
        c = value.data()["key"];
      });
    });
    super.initState();
  }

 

  void changeIndex() {
    setState(() => index = random.nextInt(3));
  }
String _question = "";
  String _a = "";
  String _b = "";
  String _c = "";
  String _d = "";
  String _ans = "";

 _openPopup(context) {
    Alert(
        context: context,
        title: "ADD QUESTION",
        content: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                icon: Text("?"),
                labelText: 'Enter the question',
              ),
              onChanged: (text) {  
                  _question = text;  
              },  
            ),
            TextField(
              decoration: InputDecoration(
                icon: Text("A"),
                labelText: 'option A',
              ),
              onChanged: (text) {  
                  _a = text;  
              },  
            ),
            TextField(
              decoration: InputDecoration(
                icon: Text("B"),
                labelText: 'option B',
              ),
              onChanged: (text) {  
                  _b = text;  
              },  
            ),
            TextField(
              decoration: InputDecoration(
                icon: Text("C"),
                labelText: 'option C',
              ),
              onChanged: (text) {  
                  _c = text;  
              },  
            ),
            TextField(
              decoration: InputDecoration(
                icon: Text("D"),
                labelText: 'option D',
              ),
              onChanged: (text) {  
                  _d = text;  
              },  
            ),
            TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.question_answer),
                labelText: 'correct answer',
              ),
              onChanged: (text) {  
                  _ans = text;  
              },  
            ),
          ],
        ),
        buttons: [
          DialogButton(
            color: Colors.purple,
            onPressed: (){
                  firestoreInstance.collection("exams").doc("$c").collection("questions")
                      .add({
                        "question" : _question,
                        "a" : _a ,
                        "b" : _b ,
                        "c" : _c ,
                        "d" : _d ,
                        "correct answer" : _ans,
                      });  
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: Text(
              "ADD",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }



Widget buildUserList(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasData) {
        return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
                DocumentSnapshot user = snapshot.data.docs[index];
                return Container(
                  alignment: Alignment.topLeft,
                  color: colors[index],
                  child: Column(
                    children: [
                    Text("QUESTION : ${user.data()['question']}",
                      style: TextStyle(fontWeight: FontWeight.bold),),
                    Text("Option A : ${user.data()['a']}",
                      style: TextStyle(fontWeight: FontWeight.bold),),
                    Text("Option B : ${user.data()['b']}",
                      style: TextStyle(fontWeight: FontWeight.bold),),
                    Text("Option C : ${user.data()['c']}",
                      style: TextStyle(fontWeight: FontWeight.bold),),
                    Text("Option D : ${user.data()['d']}",
                      style: TextStyle(fontWeight: FontWeight.bold),),
                    Text("Correct option : ${user.data()['correct answer']}",
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
        title: Text("Add Questions"),
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
    stream: FirebaseFirestore.instance.collection("exams").doc("$c").collection("questions").snapshots(),
    builder: buildUserList,
  ),
  
  floatingActionButton: new FloatingActionButton(
        onPressed: (){
          _openPopup(context);
        },
        tooltip: 'Add task',
        child: new Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
      
    );
  }
}