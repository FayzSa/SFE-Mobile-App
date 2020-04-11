import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfe_mobile_app/models/user_model.dart';
import 'package:sfe_mobile_app/screens/home/admin/mainAdmin.dart';
import 'package:sfe_mobile_app/screens/home/employes/mainEmployes.dart';
import 'package:sfe_mobile_app/services/databaseService.dart';

class HomeRedirect extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamProvider<UserData>.value(
      value: DatabaseService(uid: user.uid).userData,
      child: SafeArea(
        child: Provider.of<UserData>(context).isAdmin ? MainAdmin() : MainEmployes() ,
        ),
    );
  }
}