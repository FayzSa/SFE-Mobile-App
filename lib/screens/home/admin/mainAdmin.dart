import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfe_mobile_app/models/mail_model.dart';
import 'package:sfe_mobile_app/models/user_model.dart';
import 'package:sfe_mobile_app/services/authService.dart';
import 'package:sfe_mobile_app/services/databaseService.dart';


class MainAdmin extends StatelessWidget {

  // This will be Use to logout
 final  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<UserData>(context);
    
    //All mails 
    return StreamProvider<List<Email>>.value(
      value: DatabaseService().allEmails,
      child: Container(
        child: Text("Main Admin"),
      ),
      
    );
  }
}