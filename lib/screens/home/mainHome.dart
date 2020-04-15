import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfe_mobile_app/models/user_model.dart';
import 'package:sfe_mobile_app/screens/Auth/authenticate.dart';
import 'package:sfe_mobile_app/screens/home/admin/mainAdmin.dart';
import 'package:sfe_mobile_app/screens/home/employes/mainEmployes.dart';
class HomeMain extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    
    final userdata = Provider.of<UserData>(context); 
    return userdata == null ? Auth(): 
       SafeArea(
        child: userdata.isAdmin ? MainAdmin() : MainEmployes() ,
    );
  }
}