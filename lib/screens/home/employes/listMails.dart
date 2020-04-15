import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfe_mobile_app/models/mail_model.dart';
import 'package:sfe_mobile_app/models/user_model.dart';
import 'package:sfe_mobile_app/services/databaseService.dart';

class ListMails extends StatefulWidget {

  @override
  _ListMailsState createState() => _ListMailsState();
}

class _ListMailsState extends State<ListMails> {
 
     
 List<Email> listOfEmails;

   @override
  Widget build(BuildContext context) {
    final  emails = Provider.of<List<Email>>(context)?? []; 
   // final user = Provider.of<UserData>(context);
   return Text(emails.length.toString());
      
   
  }
}


Widget listAllMails(){
List t;
  DatabaseService().mailGest.snapshots().listen((onData){
    onData.documents.forEach((data){
      DatabaseService().mailGest.document(data.documentID).collection("Emails").snapshots().listen((da){
        da.documents.forEach((fa){
         String s =  fa.data["Body"].toString();
         t.add(s);
        });
      });
    });
    });
  return Container(
    child: Text(t == null ? "" : t),
  );
}