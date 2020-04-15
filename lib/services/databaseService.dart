import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sfe_mobile_app/models/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:sfe_mobile_app/models/mail_model.dart';


class DatabaseService 
{

  List<String> filesUrls;
  final String uid ; 
  final String depRt;
  DatabaseService({this.uid , this.depRt});
    // All functions on Database will be under : 
    final CollectionReference mailGest = Firestore.instance.collection('users');
    final CollectionReference emailsGest = Firestore.instance.collection('emails');

    final StorageReference storageRef =
        FirebaseStorage.instance.ref().child("Files/");   
    
    
    //init or Update  User Data     
  Future initUserData(String fullName , String department ,{bool isAdmin = false})async
  {
        return await mailGest.document(uid).setData({
        'Departement':department,
        'FullName':fullName,
        'isAdmin': isAdmin , 
       });
  } 

    //User Data From Snapshots 
    UserData _userDataFromSnapshot(DocumentSnapshot snapshot)
  {
    return UserData(
     uid: this.uid,
     departement: snapshot.data['Departement'],
     fullName: snapshot.data['FullName'],
     isAdmin: snapshot.data['isAdmin'],
    );
  }

    //List of Emails From Snapshot
  List<Email> _mailListFormSnapshot(QuerySnapshot querySnapshot)
 {
  return querySnapshot.documents.map((doc)
  {
    return Email(
      body: doc.data['Body'],
      title: doc.data['Title'],
      dateRecive: doc.data['DateRecive'].toString(),
      traited: doc.data['Traited'],
      repEmail:doc.data['ReplayMail'],
      files: doc.data['Files'],
      delay: doc.data["Delay"],
      mailID: doc.documentID,
      );   
  }
  ).toList();
}

  // stream of emails :
    Stream<List<Email>> get emails
  {   
       return emailsGest.where("Department",isEqualTo: depRt.toUpperCase()).snapshots().map(_mailListFormSnapshot);
      
  }

  
  // stream of emails :
    Stream<List<Email>> get allEmails
  {   
       return emailsGest.snapshots().map(_mailListFormSnapshot);
      
  }


 
  

// Stream of User Data
  Stream<UserData> get userData
  {
    return mailGest.document(uid).snapshots()
    .map(_userDataFromSnapshot);
   }
 

// send Mail
  sendMail( List<File> filesPaths, Email em , String depart)async 
  {
    List<String> urlsLinks = await uploadFiles(filesPaths);
   
       await emailsGest.add({
          "Body":em.body,
          "Title": em.title,
          "ReplayMail":{},
          "Files": urlsLinks,
          "DateRecive":em.dateRecive,
          "Traited":em.traited,
          "Delay":em.delay,
          "Department":depart.toUpperCase()
          }
        );

  }

// send Reply to an Email
sendRepaly(RepEmail repEmail , String emailID, List<File> filesPaths)async
{
    List<String> urlsLinks = await uploadFiles(filesPaths);
  Map repE = {
          "Body":repEmail.body,
          "Title": repEmail.title,
          "Files": urlsLinks,
          "replayDate":repEmail.dateRep,
         
  };

  await emailsGest.document(emailID).updateData({
      "ReplayMail":repE,
      "Traited": "Traited"
      });
}

// add files : not sure of this still need a try
  Future<List<String>> uploadFiles(List<File> paths) async{

  paths.forEach((p) async{
   StorageUploadTask uploadTask = storageRef.putFile(p);    
   await uploadTask.onComplete.then((fileURL){
     print('File Uploaded');  
     filesUrls.add(fileURL.ref.getDownloadURL().toString());
   });
  });   
  return filesUrls;
 }  
 
// notifications 





}