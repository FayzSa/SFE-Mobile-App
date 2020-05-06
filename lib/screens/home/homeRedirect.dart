import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfe_mobile_app/models/user_model.dart';
import 'package:sfe_mobile_app/screens/home/mainHome.dart';
import 'package:sfe_mobile_app/services/databaseService.dart';
import 'package:sfe_mobile_app/services/notificationservice.dart';

class HomeRedirect extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
        ///for beginning recieving messages 
    GestionNotification.configureMessaging();

    return StreamProvider<UserData>.value(
      value: DatabaseService(uid: user.uid).userData,
      child: HomeMain(),
    );
  }
}