import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class VsjTwo extends StatefulWidget {
  @override
  _VsjTwoState createState() => _VsjTwoState();

}
class _VsjTwoState extends State<VsjTwo> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text("Firebase Auth Demo"),
              centerTitle: true,
            ),
            body: Center(
                child: Column()
            )
        ));
  }
}
