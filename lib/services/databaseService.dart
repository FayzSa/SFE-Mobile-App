import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sfe_mobile_app/models/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:sfe_mobile_app/models/mail_model.dart';
import 'package:path/path.dart' as Path;

class DatabaseService 
{

  List<String> filesUrls;
  final String uid ; 
  DatabaseService({this.uid});
    // All functions on Database will be under : 
    final CollectionReference mailGest = Firestore.instance.collection('users');
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
      dateRecive: doc.data['DateRecive'],
      traited: doc.data['Traited'],
      repEmail:doc.data['ReplayMail'],
      files: doc.data['Files'],
      mailID: doc.documentID,
      );


  }
  ).toList();


}

  // stream of emails :
    Stream<List<Email>> get emails
  {
    CollectionReference mailCollection = mailGest.document(uid).collection("Emails");
     return mailCollection.snapshots().map(_mailListFormSnapshot);
  }

// Stream of User Data
  Stream<UserData> get userData
  {
    return mailGest.document(uid).snapshots()
    .map(_userDataFromSnapshot);
  }


  //Stream All Mails 
    Stream<List<Email>> get allEmails
  {
    Stream<List<Email>> allMails ; 
    mailGest.snapshots().listen((us){
     us.documents.forEach((u){
     allMails =   mailGest.document(u.documentID).
       collection("Emails").
       snapshots().map(_mailListFormSnapshot);
      });
    });
    return allMails; 
  }
  
 


// send Mail

// send Reply to an Email


// add files : not sure of this still need a try
Future<List<String>> uploadFiles(List<File> paths)  async{
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