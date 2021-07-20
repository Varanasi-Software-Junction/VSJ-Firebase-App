import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  //Firebase.initializeApp();
  runApp(FirebaseDemo());

}

class FirebaseDemo extends StatefulWidget {
  FirebaseFirestore firestoredb;//=FirebaseFirestore.instance;
  @override
  _FirebaseDemoState createState() => _FirebaseDemoState();

}

class _FirebaseDemoState extends State<FirebaseDemo> {

  String username = "", password = "", status = "Messages";

  @override
  void initState() {
    super.initState();
   firebaseInit();
  }
void firebaseInit()
{
  try {
    Firebase.initializeApp().whenComplete(() {
      widget.firestoredb=FirebaseFirestore.instance;
      print("Initialized");
    });
  } catch (ee) {
    print(ee);
  }
}
  _FirebaseDemoState() {
  //_firestoredb=  FirebaseFirestore.instance;
  }
  String firebasedata="data";
  void getMessages()
 async {
    FirebaseFirestore _firestoredb=FirebaseFirestore.instance;
    dynamic result= await  _firestoredb.collection("messages").get();
    QuerySnapshot messages=result;
    print(messages);
    firebasedata="";
    for (var message in messages.docs) {
      print(message.data());
      firebasedata=firebasedata + message.data().toString() + "\n";
      print(message.get("chatmessage"));
      print(message.get("messagefrom"));

    
     // print(message.data().chatmessage);
    }
    print(firebasedata);
setState(() {

});
  }
  void getMessagesStream()async {
    print("Streams");
    FirebaseFirestore _firestoredb = FirebaseFirestore.instance;
    dynamic result = await _firestoredb.collection("messages").snapshots();
    print(result.runtimeType);
    Stream<QuerySnapshot> ms=result;
    setState(() {

    });
    firebasedata="";
    ms.forEach((element) {
      for(var value in element.docs)

      {

        print(value.data());
        firebasedata=firebasedata + value.data().toString() + "\n";
        print(value.get("chatmessage"));
        print(value.get("messagefrom"));
      }
    });
    print(firebasedata);

    }

  @override
  Widget build(BuildContext context) {
    //firebaseInit();
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

              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                child:Text(firebasedata + "data"),
                ),
              ),


              Text(
                status,
                style: TextStyle(backgroundColor: Colors.teal),
              )
              ,
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
              ElevatedButton(
                  child: Text(
                    "Register",
                    style: TextStyle(backgroundColor: Colors.teal),
                  ),
                  onPressed: () async {
                    FirebaseAuth _auth;
                    try {
                      print("Register Pressed");

                      try {
                        _auth = FirebaseAuth.instance;

                      } catch (e1) {

                        String err=e1.errMsg();
                        status="Creation Failed $err" ;
                      }

                       dynamic result= await _auth.createUserWithEmailAndPassword(email: username, password: password);
                      if (result==null)
                        {

                          status="Creation Failed " ;
                        }
                      else
                        {
                          UserCredential newcr=result;
                          User newuser=newcr.user;
                          String mail=newuser.email;
                        status="  $mail created";

                        }

                    } catch (e) {
                      status = e.toString();

                      print(status);
                    }
                    setState(() {});
                  }),
              ElevatedButton(onPressed: () async{
print("Send");
  FirebaseFirestore _firestoredb=FirebaseFirestore.instance;
                 await     _firestoredb.collection("messages").add(
                          {
                            "chatmessage":username,
                            "messagefrom":"chmpaksworld@gmail.com"

                          });
              }, child: Text("Send Message Stream",style: TextStyle(backgroundColor: Colors.teal),)),
             ElevatedButton(onPressed: ()async{
               print("Get Messages");
               //await firebaseInit();
             //await getMessages();
              await getMessagesStream();
              
             }, child:Text("Get Message Stream",style: TextStyle(backgroundColor: Colors.teal),)
             ),









              StreamBuilder<QuerySnapshot>(
                stream:widget.firestoredb.collection("messages").snapshots() ,
                builder: (context,snapshot){
                  try {
                    if (snapshot.hasData) {
                      final messages = snapshot.data.docs;
                      List<Text> lst = [];
                      for (var message in messages) {
                        final messagetext = message.get("chatmessage");
                        final sender = message.get("messagefrom");
                        final messagetextfield = Text(
                            messagetext.toString() + " : " + sender.toString(),
                        style: TextStyle(backgroundColor: Colors.pinkAccent),);
                        lst.add(messagetextfield);

                      }
                      return Column(
                        children: lst,
                      );
                    }
                    else {
                      List<Text> lst = [];
                      lst.add(Text("Waiting"));
                      return Column(
                      children:  lst,
                      );
                    }
                  }
                  catch(e)
                  {
                    List<Text> lst = [];
                    lst.add(Text("Erromr" + e.toString()));
                    return Column( children:lst,);
                  }
                },
              ),









            ],
          ),
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
