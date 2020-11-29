import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dbms/exam.dart';
import 'package:dbms/home.dart';
import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  final int value;
  Quiz({Key key, this.value}) : super(key: key);
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {

  int l;
  List<String> soln;
  //int pass = k;
  
 @override
  Widget build(BuildContext context) {
    int pass = widget.value;
    

  firestoreInstance.collection("users").get().then((querySnapshot) {
  querySnapshot.docs.forEach((result) {
    firestoreInstance
        .collection("exams")
        .doc(result.id)
        .collection("questions")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        setState(() {
          soln.add(result.data()["correct answer"]);
        });
      });
    });
  });
});
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection('exams').doc("${widget.value}").collection("questions").get(),
        builder: (context, snapshot) {
        print(snapshot.data.toString());
    if (snapshot.hasData) {
        l = snapshot.data.docs.length;
        List<QueryDocumentSnapshot> user = snapshot.data.docs;
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => Quizpage(user :  user , n : l , pass:pass , list : soln)));

        /*return ListView.builder(
            itemCount: l,
            itemBuilder: (BuildContext context, int index) {
              
        );       
        },
        );*/
    } else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData){
        return Container(
          alignment: Alignment.center,
          height:10,
          width:10,
          child: CircularProgressIndicator()
          );
    } else {
        return Container(
          alignment: Alignment.center,
          height:10,
          width:10,
          child: CircularProgressIndicator()
          );
    }
      },
    );
  }
}



