import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfe_mobile_app/models/mail_model.dart';
import 'package:sfe_mobile_app/models/user_model.dart';
import 'package:sfe_mobile_app/screens/home/employes/listMails.dart';
import 'package:sfe_mobile_app/services/authService.dart';
import 'package:sfe_mobile_app/services/databaseService.dart';
import 'package:sfe_mobile_app/shared/loading.dart';

class MainEmployes extends StatelessWidget {
  // This will be Use to logout
  //
 
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);
    return StreamProvider<List<Email>>.value(
      value: DatabaseService(depRt: user.departement).emails,
        child: Scaffold(
        body: Column(
          children: <Widget>[
            Text(user.uid),
            RaisedButton(onPressed: (){
              Email em = Email(body: "Fayz" , dateRecive: DateTime.now().toString() , files: [] , title: "Fatzz" , traited: "Still"  );
              DatabaseService().sendMail([],em,"RH");
            }
            ),
            RaisedButton(onPressed: () async{
              Loading();
              await AuthService().signOut();
            }),
            ListMails(),
          ],
        ),
      ),
    );
  }
}