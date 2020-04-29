import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' as path;
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
    final CollectionReference departGest = Firestore.instance.collection('Departments');

    final StorageReference storageRef =
        FirebaseStorage.instance.ref();   
    
    
    //init or Update  User Data     
  Future initUserData(String fullName , String department ,bool isAdmin)async
  {
        return await mailGest.document(uid).setData({
        'Departement':department,
        'FullName':fullName,
        'isAdmin': isAdmin, 
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
      department: doc.data['Department'],
      mailID: doc.documentID,
      );   
  }
  ).toList();
}

updateTraited(Email em)async
{
    await emailsGest.document(em.mailID).updateData({
      "Traited": "Traited"
      });
}
      updateTraite(Stream<QuerySnapshot> allEmails){
     
       allEmails.map(_mailListFormSnapshot).listen((onData){
         onData.forEach((f){
           var today = DateTime.now();
           var lastDay = DateTime.parse(f.dateRecive).add((Duration(days: f.delay)));
           var diffrence = today.difference(lastDay).inMinutes;
          if(diffrence > 0 && f.traited != "Traited" && f.traited != "Not Traited") {
           // print(diffrence);
              emailsGest.document(f.mailID).updateData({
                "Traited": "Not Traited",
                
              });
          }
         
         if(diffrence > 0 && f.repEmail.isEmpty )
          {
              emailsGest.document(f.mailID).updateData({
                "ReplayMail": {"NOTHING":"NOTHING"},
                
              });
          }
         });
       });
    } 
  // stream of emails :
    Stream<List<Email>> get emails
  {   // remove to upper
     Stream<QuerySnapshot> allEmails = emailsGest.where("Department",whereIn: [ depRt , "Tous"])
       .orderBy("DateRecive",descending: true)
       .snapshots();
       updateTraite(allEmails);
      return allEmails.map(_mailListFormSnapshot);
      
  }

    Stream<List<Email>> get traitedEmails
  {   
     Stream<QuerySnapshot> allEmails =
      emailsGest.
      where("Department",whereIn: [ depRt , "Tous"]).
      where("Traited",isEqualTo: "Traited").
      orderBy("DateRecive",descending: true).
      snapshots();
      updateTraite(allEmails);
      return allEmails.map(_mailListFormSnapshot);
      
  }

      Stream<List<Email>> get nonTraitedEmails
  {   

     Stream<QuerySnapshot> allEmails = 
        emailsGest.
        where("Department",isEqualTo:depRt).
        where("Traited",whereIn : ["Not Traited" , "Still"]).
        //where("Traited" , isEqualTo: "Still").
        orderBy("DateRecive",descending: true).
        snapshots();
        updateTraite(allEmails);
      return allEmails.map(_mailListFormSnapshot);
      
  }
  
  // stream of emails :
    Stream<List<Email>> get allEmails
  {   
    Stream<QuerySnapshot> allEmails = emailsGest.orderBy("DateRecive",descending: true).snapshots();
      updateTraite(allEmails);
       return allEmails.map(_mailListFormSnapshot);
      
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
    List<String> urlsLinks = await uploadFilesAdmins(filesPaths,em) ?? [];
   
       await emailsGest.add({
          "Body":em.body,
          "Title": em.title,
          "ReplayMail":{},
          "Files": urlsLinks,
          "DateRecive":em.dateRecive,
          "Traited":em.traited,
          "Delay":em.delay,
          "Department":depart // Remove To Upper
          }
        );

  }


// send Reply to an Email
sendRepaly(RepEmail repEmail , String emailID, List<File> filesPaths)async
{
    List<String> urlsLinks = await uploadFiles(filesPaths , emailID)?? [];
    
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

// add files for Services
  Future<List<String>> uploadFiles(List<File> paths , String mailID) async{
    List<String> fileURLS = List();
  if(paths ==  null ) return []; 
  for(int i =0 ; i < paths.length ; i++)
  {
    String filename =  path.basename(paths[i].path);
     final StorageReference storageRef =
        FirebaseStorage.instance.ref().child("$uid/$mailID/$i$filename");
    
   final StorageUploadTask uploadTask = storageRef.putFile(paths[i]);
   await uploadTask.onComplete;
     String imageUrl = await storageRef.getDownloadURL();
        fileURLS.add(imageUrl);
  }  
   
  return fileURLS;
 }  

 // Add Files for Admins


 Future<List<String>> uploadFilesAdmins(List<File> paths , Email em ) async{
    List<String> fileURLS = List();
  if(paths ==  null ) return []; 
  for(int i =0 ; i < paths.length ; i++)
  {
    String filename =  path.basename(paths[i].path);
     final StorageReference storageRef =
        FirebaseStorage.instance.ref().child("${em.department}/${em.title}/$i$filename");
    
   final StorageUploadTask uploadTask = storageRef.putFile(paths[i]);
   await uploadTask.onComplete;
     String imageUrl = await storageRef.getDownloadURL();
        fileURLS.add(imageUrl);
  }  
   
  return fileURLS;
 }  
 
 
// notifications 





// Departemnts Gestion 

//Departs from snapshot 

    //User Data From Snapshots 
    List<Departs> _departsFromSnapshot(QuerySnapshot snapshot)
  {
    return snapshot.documents.map((doc){
      return Departs(
        departID: doc.documentID,
        departsName: doc.data["DepartName"],
      );
    }).toList();
  }

    
//Stream of departs
  Stream<List<Departs>> get departments
  {
    return departGest.snapshots()
    .map(_departsFromSnapshot);
   }

//Add 
addDeprt(String depName) async{
  await departGest.add({
    "DepartName":depName
  });
}
//Delete 
delDeprt(String depID) async{
  departGest.document(depID).delete();
}
//Update 

updateDeprt(String  depNew ,String depID) async{
  departGest.document(depID).updateData(
    {
      "DepartName":depNew
    }
  );
}


//Delete Users //{Disable} User


//Update User only Admin 



}