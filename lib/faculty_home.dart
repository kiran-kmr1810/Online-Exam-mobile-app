import 'package:dbms/faculty_pages/create_test.dart';
import 'package:dbms/faculty_pages/fac_mark.dart';
import 'package:dbms/infopage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/authentication_service.dart';
import 'global.dart' as globals;


class Facultyhome extends StatefulWidget {
  @override
  _FacultyhomeState createState() => _FacultyhomeState();
}

class _FacultyhomeState extends State<Facultyhome> {
@override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar : AppBar(
        centerTitle: true,
        title: Text("Online Exam System"),
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
        onTap: () {

        },
        child: Icon(
            Icons.settings
        ),
      )
    ),
  ],
),
body: Container(
    alignment: Alignment.center,
    child : new Column(
    children: <Widget> [
      RaisedButton(onPressed: (){
        Navigator.push(context,MaterialPageRoute(builder: (context) => Createtest()));
      },
      child: new Text("EXAMS",
          style: TextStyle(
            fontSize: 25,
            fontWeight : FontWeight.bold,
            fontStyle: FontStyle.italic,
          ), 
      ),
      color: Colors.black,
      textColor: Colors.white,
      ),

      RaisedButton(onPressed: (){
        Provider.of<AuthenticationService>(context,listen: false).signOut();
      },
      child: new Text("Log out",style: TextStyle(
            fontSize: 25,
            fontWeight : FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),),
      color: Colors.black,
      textColor: Colors.white,
      ),
      
    ]    
  )
),);}
}
