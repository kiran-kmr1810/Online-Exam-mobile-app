import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:dbms/global.dart';
import 'package:dbms/home.dart';
import 'package:dbms/resultpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Quizpage extends StatefulWidget {
    
  final List<QueryDocumentSnapshot> user;
  final int n;
  final int pass;
  final List<String> list;

  const Quizpage({Key key, @required this.user,this.n,this.pass,this.list}) : super(key: key);
  @override
  _QuizpageState createState() => _QuizpageState();
}

class _QuizpageState extends State<Quizpage> {

  int i = 0;
  int sol = -1;
  List<String> option = ["a","b","c","d"];
  int mark = 0;
  int change = 0;
  var answer = new List(3);


  openPopup(context) {
    Alert(
        context: context,
        title: "RESULT",
        content: Container(
          child: Text(
            "your mark is $mark",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
    );
   }

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
    body: Swiper(itemCount: widget.n,
    itemBuilder: (context, index) {
      print("${widget.n} and $index");
      return card(index);
    },
    ),
    );
     
  }

  void _nextSubmit()  {
      {
      FirebaseFirestore.instance.collection("users").doc(firebaseUser.uid).collection("mymark").doc().set({
        "${widget.pass}" : "$mark"
          }).then((_) {
        });
      FirebaseFirestore.instance.collection("exams").doc("${widget.pass}").collection("marklist").doc().set({
        "${firebaseUser.uid}" : "$mark"
          }).then((_) {
        });
       
    }
  }

  Widget result(){
return Scaffold(
      backgroundColor: Colors.blueGrey[850],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[800],
        title: Text(
          "RESULT",
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Material(
              elevation: 10.0,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 5.0,
                        horizontal: 15.0,
                      ),
                      child: Center(
                      child: Text(
                        "you scored $mark",
                        style: TextStyle(
                          fontSize: 22.0,
                          fontFamily: "Quando",
                        ),
                      ),
                    )
                    ),
                  ],
                ),
              ),
            ),            
          ),
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OutlineButton(
                  onPressed: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Studenthome(),
                    ));
                  },
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 25.0,
                  ),
                  borderSide: BorderSide(width: 3.0, color: Colors.indigo),
                  splashColor: Colors.indigoAccent,
                )
              ],
            ),
          )
        ],
      ),
    );
}


Widget card(int i){
  return Container(
       /* appBar: AppBar(
        centerTitle: true,
        title: Text(""),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
              Colors.black,
              Colors.black
            ]
          )          
         ),        
     ), 
),*/
        child: Stack(
          children: <Widget>[
            ClipPath(
              clipper: WaveClipperTwo(),
              child: Container(
                decoration:
                    BoxDecoration(color: Colors.black),
                height: 200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white70,
                        child: Text("${i + 1}"),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: Text(
                          widget.user[i].data()["question"],
                          style: TextStyle(color: Colors.white,fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.start, 
                          children: <Widget>[
                          new Radio(value: 0, groupValue: sol , 
                          onChanged:(value){
                            setState(() {
                              sol = value;
                              answer[i] = option[sol]; 
                            });
                          }
                          ),
                          new Text(widget.user[i].data()["a"])
                          ]
                          ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.start, 
                          children: <Widget>[
                          new Radio(value: 1, groupValue: sol , onChanged:(value){
                            setState(() {
                              sol = value;
                              answer[i] = option[sol]; 
                            });
                          }),
                          new Text(widget.user[i].data()["b"])
                          ]
                          ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.start, 
                          children: <Widget>[
                          new Radio(value: 2, groupValue: sol , onChanged:(value){
                            setState(() {
                              sol = value;
                              answer[i] = option[sol]; 
                            });
                          }),
                          new Text(widget.user[i].data()["c"])
                          ]
                          ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.start, 
                          children: <Widget>[
                          new Radio(value: 3, groupValue: sol , onChanged:(value){
                            setState(() {
                              sol = value;
                              answer[i] = option[sol]; 
                            });
                          }),
                          new Text(widget.user[i].data()["d"])
                          ]
                          ), 
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: RaisedButton(
                        padding: MediaQuery.of(context).size.width > 800
                              ? const EdgeInsets.symmetric(vertical: 20.0,horizontal: 64.0) : null,
                        child: Text("Submit"
                                , style: MediaQuery.of(context).size.width > 800
                              ? TextStyle(fontSize: 30.0) : null,),
                        onPressed: () {
                          print(answer);
                          print(widget.list);
                          print(mark);
                          _nextSubmit();
                          result();
                        },
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
    );
}




}

