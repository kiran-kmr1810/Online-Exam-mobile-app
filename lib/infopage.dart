import 'package:dbms/global.dart';
import 'package:dbms/home.dart';
import 'package:dbms/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'global.dart' as globals;


class Infopage extends StatefulWidget {
  @override
  _InfopageState createState() => _InfopageState();
}

class _InfopageState extends State<Infopage> {

Widget fieldname(comm){
 return Padding(
    padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
    child: new Row(
      mainAxisSize: MainAxisSize.max,
    children: <Widget>[
      new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
      new Text('$comm',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),],),],));}


Widget field(value){
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Flexible(
            child: new Text(value),),],));}



@override
Widget build(BuildContext context) {

      firestoreInstance.collection("users").doc(firebaseUser.uid).get().then((value){
      setState((){globals.name = (value.data()['name']) as String;});
      setState((){globals.rollnumber = (value.data()['rollno']) as String;});
      setState((){globals.fid = (value.data()['facultyid']) as String;});
      setState((){globals.department = (value.data()['department']) as String;});
      setState((){globals.gender = (value.data()['gender']) as String;});
      setState((){globals.mailid = (value.data()['mail_id']) as String;});
      setState((){globals.mobile = (value.data()['mobile']) as String;});
      setState((){globals.dob = (value.data()['dob']) as String;});
      setState((){globals.role = (value.data()['role']) as String;});
     });


if(globals.role == "faculty"){
  setState((){globals.rorf = "facultyid";});
  setState((){globals.rorfv = globals.fid;});
}
else{
  setState((){globals.rorf = "rollno";});
  setState((){globals.rorfv = globals.rollnumber;});
}

return new Scaffold(
    appBar : AppBar(
            centerTitle: true,
            title: Text("My Profile"),
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
            onTap: () {},
            child: Icon(
                Icons.settings
            ),
          )
        ),
      ],
    ),
        body: new Container(
          color: Colors.white,
          child: new ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  new Container(
                    height: 250.0,
                    color: Colors.white,
                    child: new Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child:
                              new Stack(fit: StackFit.loose, children: <Widget>[
                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Container(
                                    width: 140.0,
                                    height: 140.0,
                                    decoration: new BoxDecoration(
                                      color: Colors.blueGrey,
                                      shape: BoxShape.circle,
                                    )),
                              ],
                            ),
                          ]),
                        )
                      ],
                    ),
                  ),
                  new Container(
                    color: Color(0xffFFFFFF),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: new Column(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 15.0),
                              child: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Personal Information',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          fieldname("Name"), 
                          field(globals.name),
                          fieldname("$rorf"),
                          field(globals.rorfv),
                          fieldname("Department"),
                          field(globals.department),
                          fieldname("Date of birth"),
                          field(globals.dob),
                          fieldname("Gender"),
                          field(globals.gender),
                          fieldname("Mail id"),
                          field(globals.mailid),
                          fieldname("Mobile number"),
                          field(globals.mobile),
              RaisedButton(
                onPressed:() {
                  Provider.of<AuthenticationService>(context,listen: false).signOut();
                  setState(() {
                    globals.radioValue = -1;
                  });
                },
                padding: EdgeInsets.all(15),
                textColor: Colors.white,
                color: Colors.black,
                child: Text(
                  "sign out" , style: TextStyle(
                    color : Colors.white
                  ),
                ),
              ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        )
);

}
}
