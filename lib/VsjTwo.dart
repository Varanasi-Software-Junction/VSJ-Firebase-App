import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class VsjTwo extends StatelessWidget {
String message="",sender="";
VsjTwo(String message,String sender)
{
  this.message=message;
  this.sender=sender;
}
static TextStyle myTextStyle()
{
  return TextStyle(color: Colors.white,backgroundColor: Colors.blue,fontSize: 20,);
}
static InputDecoration myInputDecoration() {
 return InputDecoration(hintText: "Text Input", border: OutlineInputBorder());
}
  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.blueAccent,
        elevation: 5.0,
        borderRadius: BorderRadius.circular(10),
        child:
    Row(

                  children: [Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(message,style:myTextStyle(),),

                  ),
                   Padding(
                     padding: const EdgeInsets.all(2.0),
                     child: Text(" : ",style: TextStyle(backgroundColor: Colors.white),),
                   )
                    ,Text(sender,style:myTextStyle(),)],
                )
    )

        ;
  }
}
