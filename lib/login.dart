import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'animations/FadeAnimation.dart';
import "services/authentication_service.dart";
import 'global.dart' as globals;

class Loginpage extends StatefulWidget {
  @override
  _LoginpageState createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {


  String email = "";
  String password = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[800],
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FadeAnimation(1.2, Text("LOGIN", 
            style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),)),
            SizedBox(height: 30,),
            FadeAnimation(1.5, Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey[300]))
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
                        hintText: "Email Id"
                      ),
                      onChanged: (mail) {
                          email = mail;
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey[300]))
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
                        hintText: "Password"
                      ),
                      obscureText: true,
                      onChanged: (pw) {
                          password = pw;   
                      },
                    ),
                  ),
                Container(
                 child : new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Radio(
                          value: 0,
                          groupValue: globals.radioValue,
                          onChanged: (value) {
                            setState(() {
                              globals.radioValue = value;
                            });
                          },
                        ),
                        new Text(
                          'Student',
                          style: new TextStyle(fontSize: 16.0),
                        ),
                        new Radio(
                          value: 1,
                          groupValue: globals.radioValue,
                          onChanged: (value) {
                            setState(() {
                              globals.radioValue = value;
                            });
                          },
                        ),
                        new Text(
                          'Faculty',
                          style: new TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        ]
                  )
                )
                ],
              ),
            )),
            SizedBox(height: 40,),
            FadeAnimation(1.8, Center(
              child:RaisedButton(
                onPressed:() {
                  Provider.of<AuthenticationService>(context,listen: false).signIn(
                    email: email,
                    password: password
                  );
                  print(User);
                },
                padding: EdgeInsets.all(15),
                textColor: Colors.white,
                color: Colors.black,
                child: Text(
                  "ENTER" , style: TextStyle(
                    color : Colors.white
                  ),
                ),
              )
            )),
          ],
        ),
      ),
    );
  }
}

