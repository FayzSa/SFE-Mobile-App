import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sfe_mobile_app/models/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:sfe_mobile_app/models/mail_model.dart';


class DatabaseService 
{
  final String uid ; 
  DatabaseService({this.uid});
    // All functions on Database will be under : 
    final CollectionReference mailGest = Firestore.instance.collection('users');
    
    
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

  

  //send Mail


  //send Reply to Email

  


}