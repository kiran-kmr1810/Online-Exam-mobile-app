import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dbms/faculty_home.dart';
import 'package:dbms/global.dart' as globals;
import 'package:dbms/global.dart';
import 'package:dbms/home.dart';
import 'package:dbms/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/authentication_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthenticationService>().authStateChanges,
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatefulWidget {
  @override
  _AuthenticationWrapperState createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
   
  String v ;
 // String role;
  var firebaseUser =  FirebaseAuth.instance.currentUser;

    /*Future<void> getrole() async {
    var document = firestoreInstance.collection("group").doc(firebaseUser.uid).get();
    return await document.then((value) {
      setState(() {
          v = value.data()["role"];
        }); 
    });
    }*/

  @override
  Widget build(BuildContext context) {
     
    return new StreamBuilder(
      
      stream: FirebaseAuth.instance.authStateChanges(),
      builder:(BuildContext context , snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          print("loading");
        }
        if(snapshot.hasData){
          
             firestoreInstance.collection("users").doc(firebaseUser.uid).get().then((value){
              if(value.data()["role"] == "faculty"){
                setState(() {
                  v = "faculty";
                });
                print(value.data()["role"]);
              }
              if(value.data()["role"] == "student"){
                setState(() {
                  v = "student";
                });
               // print(value.data()["role"]);
              }
            });

            //getrole();

            if(globals.radioValue == 0){
                  return Studenthome();
            }
            if(globals.radioValue == 1){ 
                return Facultyhome();
            }

        }
        return Loginpage();
      }
    );
        
  }
}

