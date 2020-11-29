import 'package:dbms/faculty_pages/add_questions.dart';
import 'package:dbms/faculty_pages/create_test.dart';
import 'package:dbms/home.dart';
import 'package:dbms/infopage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:dbms/global.dart' as globals;
import 'package:flushbar/flushbar.dart';

class Addtest extends StatefulWidget {
  @override
  _AddtestState createState() => _AddtestState();
}

class _AddtestState extends State<Addtest> {

  final _formKey = GlobalKey<FormState>(); 


  String testname = "";
  String coursecode = "";
  DateTime _date ;
  DateTime _starttime ;
  DateTime _endtime ;
  int c;

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

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
       appBar : AppBar(
        centerTitle: true,
        title: Text("Creating Test"),
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
body: new Container(
  child : new Form(
    key: _formKey, 
    child: new ListView(
      children: [
        new TextFormField(
          decoration: InputDecoration(
            hintText: "Enter Test Name",
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.text,
          onChanged: (text){
            testname = text;
          },
        ),
        new TextFormField(
          decoration: InputDecoration(
            hintText: "Enter Course code",
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.text,
          onChanged: (course){
            coursecode = course;
          },
        ),
        Container(
          height: 50,
          alignment: Alignment.centerLeft,
          child : Text("Choose the Test date"),
        ),
        RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 4.0,
                onPressed: () {
                  DatePicker.showDatePicker(context,
                      theme: DatePickerTheme(
                        containerHeight: 210.0,
                      ),
                      showTitleActions: true,
                      minTime: DateTime(2000, 1, 1),
                      maxTime: DateTime(2022, 12, 31), onConfirm: (date) {
                    print('confirm $date');
                    _date = date;
                    setState(() {});
                  }, currentTime: DateTime.now(), locale: LocaleType.en);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.date_range,
                                  size: 18.0,
                                  color: Colors.black,
                                ),
                                Text(
                                  " $_date",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Text(
                        "  Change",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
                color: Colors.white,
              ),
              SizedBox(
                height: 20.0,
              ),
        Container(
          height: 50,
          alignment: Alignment.centerLeft,
          child : Text("Test start time"),
        ),
        RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 4.0,
                onPressed: () {
                  DatePicker.showTimePicker(context,
                      theme: DatePickerTheme(
                        containerHeight: 210.0,
                      ),
                      showTitleActions: true, onConfirm: (time) {
                    print('confirm $time');
                    _starttime = time;
                    setState(() {});
                  }, currentTime: DateTime.now(), locale: LocaleType.en);
                  setState(() {});
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.access_time,
                                  size: 18.0,
                                  color: Colors.black,
                                ),
                                Text(
                                  " $_starttime",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Text(
                        "  Change",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
                color: Colors.white,
              ),
        Container(
          height: 50,
          alignment: Alignment.centerLeft,
          child : Text("Test end time"),
        ),
        RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 4.0,
                onPressed: () {
                  DatePicker.showTimePicker(context,
                      theme: DatePickerTheme(
                        containerHeight: 210.0,
                      ),
                      showTitleActions: true, onConfirm: (time) {
                    _endtime = time;
                    print(_endtime);
                    setState(() {});
                  }, currentTime: DateTime.now(), locale: LocaleType.en);
                  setState(() {});
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.access_time,
                                  size: 18.0,
                                  color: Colors.black,
                                ),
                                Text(
                                  " $_endtime",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Text(
                        "  Change",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
                color: Colors.white,
              ),

        RaisedButton(
          color: Colors.purple,
          onPressed: (){
            
              //super.initState();
              print("inside onpr $c");

              firestoreInstance.collection("exams").doc("$c").set({
              "test name" : testname,
              "course code" : coursecode,
              "start time": _starttime,
              "end time": _endtime ,
              "date": _date,
              "key": c,
            },
          ).then((value){

         
          });
          Navigator.push(context,MaterialPageRoute(builder: (context) => Questions()),);
          Flushbar(
              message: "Test created sucessfully , now add questions",
              icon: Icon(
                Icons.info_outline,
                size: 28.0,
                color: Colors.blue[300],
                ),
              duration: Duration(seconds: 3),
              leftBarIndicatorColor: Colors.blue[300],
            )..show(context);
          },
            child: Text(
              "ADD QUESTIONS",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ), ),
            RaisedButton(
            onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (context) => Createtest()));
            firestoreInstance.collection("keys").doc("Krt05MBMjb9Ro6LIMEhf").update({"key": c+1});
              },
            color: Colors.purple,
            child: Text("FINISH",style: TextStyle(color: Colors.white, fontSize: 20)),
            )
      ],
    ) ,

  )
),
);}}