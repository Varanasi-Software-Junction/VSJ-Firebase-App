#Firebase Demo repository is the main Firebase Demo repository for learning the use of Firebase in Flutter.
This repository illustrates adding Firebase to a project, using FirebaseAuth and Firestore. It also illustrates sending data to a Firebase document, pulling data and also pushing data via snapshots.
1. We start with creating a flutter project and decide on a package name and enter it in the app level gradle file
https://github.com/Varanasi-Software-Junction/firebasedemo/blob/main/android/app/build.gradle
The relevant entry is 
 defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId "com.varanasisoftwarejunction.cloud.firebasedemo"
        minSdkVersion 21

        targetSdkVersion 30
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
    }
Don't forget to advance the minSdkVersion to 21 because Firestore isn't supported before that.
2. Next step, we generate a google-services.json file from Firebase and add it to the app directory.
https://github.com/Varanasi-Software-Junction/firebasedemo/blob/main/android/app/google-services.json
We require some more entries in the app gradle file at https://github.com/Varanasi-Software-Junction/firebasedemo/blob/main/android/app/build.gradle.
The relevant entries

dependencies {
    implementation "org.jetbrains.kotlin:kotlin-stdlib-jdk7:$kotlin_version"
    implementation platform('com.google.firebase:firebase-bom:28.2.0')
    implementation 'com.google.firebase:firebase-analytics'
}
3. We also have entries to be done in the project level gradle. https://github.com/Varanasi-Software-Junction/firebasedemo/blob/main/android/build.gradle.
  repositories {
        google()
        jcenter()
    }

    dependencies {
        classpath 'com.android.tools.build:gradle:4.1.0'
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
        classpath 'com.google.gms:google-services:4.3.8'
    }
}

allprojects {
    repositories {
        google()
        jcenter()
    }
}
4. Then we need some entries in the pubspec.yaml file https://github.com/Varanasi-Software-Junction/firebasedemo/blob/main/pubspec.yaml
dependencies:
  flutter:
    sdk: flutter



  cupertino_icons: ^1.0.2
  firebase_core: ^1.3.0
  firebase_auth: ^2.0.0
  cloud_firestore: ^2.3.0
5. The relevant libraries have to be imported into the dart files. In our case the main.dart file at https://github.com/Varanasi-Software-Junction/firebasedemo/blob/main/lib/main.dart.
import 'dart:convert';

import 'package:firebasedemo/VsjTwo.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Next initialize Firebase in the main function itself
void main() async {
    {
 try {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
 }
 catch(e) {}
  }
  runApp(FirebaseDemo());
}
6. 
Next, we create an instance of  Firestore
The relevnt code is
 static FirebaseFirestore firestoredb;
 FirebaseDemo.firestoredb = FirebaseFirestore.instance;
To add a message 
ElevatedButton(onPressed: ()async{
  await     FirebaseDemo.firestoredb.collection("messages").add(
      {
        "chatmessage":chatmessage,
        "messagefrom":username,
        "time":DateTime.now().millisecondsSinceEpoch,
      });
7. Reading Messages by pulling

 String firebasedata = "data";
  void getMessages() async {
    dynamic result =
        await FirebaseDemo.firestoredb.collection("messages").get();
    QuerySnapshot messages = result;
    print(messages);
    firebasedata = "";
    for (var message in messages.docs) {
      print(message.data());
      firebasedata = firebasedata + message.data().toString() + "\n";
      print(message.get("chatmessage"));
      print(message.get("messagefrom"));
    }
    print(firebasedata);
    setState(() {});
  }
8. Get Messages as a stream. This will update automatically
 void getMessagesStream() async {
    print("Streams");

    dynamic result =
        await FirebaseDemo.firestoredb.collection("messages").snapshots();
    print(result.runtimeType);
    Stream<QuerySnapshot> ms = result;
    setState(() {});
    firebasedata = "";
    ms.forEach((element) {
      for (var value in element.docs) {
        print(value.data());
        firebasedata = firebasedata + value.data().toString() + "\n";
        print(value.get("chatmessage"));
        print(value.get("messagefrom"));
      }
    });
    print(firebasedata);
  }
  9. Displaying in a list view


 children: <Widget>[
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseDemo.firestoredb
                    .collection("messages").where("messagefrom", isEqualTo: "champak").orderBy("time")
                    //.collection("messages").where("messagefrom", isEqualTo: "champak")
                    .snapshots(),
                builder: (context, snapshot) {
                  try {
                    if (snapshot.hasData) {
                      final messages = snapshot.data.docs;
                      List<Widget> lst = [];
                      for (var message in messages) {
                        final messagetext = message.get("chatmessage");
                        final sender = message.get("messagefrom");
                        final messagetextfield = VsjTwo(
                          messagetext.toString(),
                              sender.toString(),
                          );
                        lst.add(messagetextfield);
                        lst.add(SizedBox(
                          height: 10,
                        ));
                      }
                      return Column(
                        children: lst,
                      );
                    } else {
                      List<Text> lst = [];
                      lst.add(Text("Waiting"));
                      return Column(
                        children: lst,
                      );
                    }
                  } catch (e) {
                    List<Text> lst = [];
                    lst.add(Text("Erromr" + e.toString()));
                    return Column(
                      children: lst,
                    );
                  }
                },
              ),

We have created ou own widget at

https://github.com/Varanasi-Software-Junction/firebasedemo/blob/main/lib/VsjTwo.dart

10.Firebase Auth The file is at https://github.com/Varanasi-Software-Junction/firebasedemo/blob/1cd1e9096a5ba8092ddccac9598d3de53bebd9a9/lib/main.dart.
dynamic _auth;
dynamic result= await _auth.createUserWithEmailAndPassword(email: username, password: password);
                      status=result.toString();
                      print(status);






 
