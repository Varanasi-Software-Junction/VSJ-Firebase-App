import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(FirebaseDemo());

}

class FirebaseDemo extends StatefulWidget {
  @override
  _FirebaseDemoState createState() => _FirebaseDemoState();

}

class _FirebaseDemoState extends State<FirebaseDemo> {
  String username = "", password = "", status = "Messages";

  @override
  void initState() {
    super.initState();
    /* Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
    */
  }

  _FirebaseDemoState() {}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Firebase Auth Demo"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "status",
                style: TextStyle(backgroundColor: Colors.teal),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    username = value;
                    print(username);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  obscureText: true,
                  onChanged: (value) {
                    password = value;
                    print(password);
                  },
                ),
              ),
              RaisedButton(
                  child: Text(
                    "Press",
                    style: TextStyle(backgroundColor: Colors.teal),
                  ),
                  onPressed: () async {
                    FirebaseAuth _auth;
                    try {
                      print("Pressed");
                      try {
                         Firebase.initializeApp().whenComplete(() {
                           print("Initialized");
                         });
                      } catch (ee) {
                        print(ee);
                      }
                      try {
                        _auth = FirebaseAuth.instance;

                      } catch (e1) {}

                      // dynamic result= await _auth.createUserWithEmailAndPassword(email: username, password: password);
                      //status=result.toString();
//User newuser=result;
                      FirebaseFirestore _firestoredb=FirebaseFirestore.instance;
                      _firestoredb.collection("messages").add(
                          {
                            "chatmessage":"Hello champak",
                            "messagefrom":"chmpaksworld@gmail.com"

                          });
                     // print(status);
                    } catch (e) {
                      status = e.toString();

                      print(status);
                    }
                    setState(() {});
                  })
            ],
          ),
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
