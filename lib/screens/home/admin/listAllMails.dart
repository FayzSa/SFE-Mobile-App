import 'dart:async';

import "package:flutter/material.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sfe_mobile_app/models/mail_model.dart';

import 'mailTailAdmin.dart';
class ListAllMails extends StatefulWidget {
  @override
  _ListAllMailsState createState() => _ListAllMailsState();
}

class _ListAllMailsState extends State<ListAllMails> {

     Widget toShowBefore  = Center (child: SpinKitCircle(
  color: Colors.black87,
  size: 50.0));
  @override
  void initState() { 
    super.initState();
    Timer(Duration(seconds: 10), (){
      setState(() {
         toShowBefore = Center(child: Text("There's No Email yet",style: TextStyle(
        color: Colors.black87,
        fontSize: 20,
      ),),);
      });
     
    });
  }
  
 

  @override
  Widget build(BuildContext context) {
       final  allEmails = Provider.of<List<Email>>(context) ?? []; 
 
   return allEmails.length == 0 ? toShowBefore
     : ListView.builder(
       itemCount: allEmails.length,
       itemBuilder: (context ,index)
       {
         return MailTileAdmin(email: allEmails[index]);
       }
       
       
       
     );
  }
}