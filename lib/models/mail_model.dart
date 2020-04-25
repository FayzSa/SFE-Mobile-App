import 'package:cloud_firestore/cloud_firestore.dart';

class Email
{
  String mailID;
  String title;
  String body ; 
  String dateRecive ; 
  List<dynamic> files; 
  String traited;
  Map repEmail;
  int delay;
  Email({this.mailID,this.title , this.body , this.dateRecive , this.files ,this.delay ,  this.traited ,this.repEmail });
  factory Email.fromFireStore(DocumentSnapshot doc)
  {
    Map data = doc.data ;
    return Email(
       body: data['Body'],
      title: data['Title'],
      dateRecive: data['DateRecive'],
      traited: data['Traited'],
      repEmail:data['ReplayMail'],
      files: data['Files'],
      delay: data["Delay"],
      mailID: doc.documentID,
    );
  }
}

class RepEmail 
{
  String title;
  String body ; 
  DateTime dateRep ; 
  List<String> files; 
  RepEmail({this.title , this.body , this.dateRep , this.files  });
}
