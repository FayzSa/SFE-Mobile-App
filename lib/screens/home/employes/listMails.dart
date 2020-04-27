import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sfe_mobile_app/models/mail_model.dart';
import 'package:sfe_mobile_app/shared/mailTile.dart';

class ListMails extends StatefulWidget {

  @override
  _ListMailsState createState() => _ListMailsState();
}
class _ListMailsState extends State<ListMails> {

  Widget toShowBefore  = Center (child: SpinKitCircle(
  color: Colors.black87,
  size: 50.0));
  @override
  void initState() { 
    super.initState();
    Timer(Duration(seconds: 10), (){
      setState(() {
         toShowBefore = Center(child: Text("You Have No Email",style: TextStyle(
        color: Colors.black87,
        fontSize: 20,
      ),),);
      });
     
    });
  }
  

   @override
  Widget build(BuildContext context) {
    final  emails = Provider.of<List<Email>>(context) ?? []; 
     return emails.length == 0 ? toShowBefore
     : ListView.builder(
       itemCount: emails.length,
       itemBuilder: (context ,index)
       {
         return MailTile(email: emails[index]);
       }
       
       
       
     );}
}


