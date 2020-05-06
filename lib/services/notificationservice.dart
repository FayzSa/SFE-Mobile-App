import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
class GestionNotification {

 static final  FirebaseMessaging _fcm = new  FirebaseMessaging();
     dynamic addtotopic(String topic) async{
     return await  _fcm.subscribeToTopic('$topic');
    }
  static configureMessaging() async{
    print("token is : "+ await _fcm.getToken());
    
     _fcm.configure(onResume: (Map<String,dynamic> message){
          print(message['notification']['title']);
     },
                  onMessage: (Map<String,dynamic> message){
          print(message['notification']['title']);
         
     },
     );
  }
  static saveTokeninthedatabase({String uid}) async{
    String token = await _fcm.getToken();
    await Firestore.instance.collection('topics').document(uid).setData({'token' : token});
  }
  static getToken() async {
    return await _fcm.getToken();
  }
     sendNotification(String title ,String message,{String topic='',String token=''})  async{
     
     String serverkey = 'key=AAAAiyiFp0k:APA91bHPX3mLLOlHqrZiqnlmQWrb7z8k7qJh_e4am6Lh5o8qKcbgXVcfkZxioZ8C5Sy3mhtMouNq23SXaGqxFsvbmZNtvjm2wYySQ-yXMbuMCNOhJ9jeiY8TOIC8WNZib1Zpr_p2_YTH';
    
             Response rep;
             try {
      rep = await http.post(
    'https://fcm.googleapis.com/fcm/send',
    headers: <String, String>{
      'Authorization' : serverkey,
      'Content-Type': 'application/json; charset=UTF-8',
      
    },
    body: jsonEncode(
        <String, dynamic>{
       'notification': <String, dynamic>{
         'body': message,
         'title': '$title'
       },
       'priority': 'high',
       'data': <String, dynamic>{
         'click_action': 'FLUTTER_NOTIFICATION_CLICK',
         'id': '1',
         'status': 'done'
       },
       'to': topic!=''?'/topics/$topic':(token!=''?'$token':''),
     },


    ),
  );}catch(e){
    print('erreur');
    return 402;
  }
  return rep.statusCode;
   }

dynamic getTokenfromdatabase({String uid}) async{
    DocumentSnapshot token = await Firestore.instance.collection('topics').document(uid).get();
    return await token.data.values.first;
}

}