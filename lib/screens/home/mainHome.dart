import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfe_mobile_app/models/mail_model.dart';
import 'package:sfe_mobile_app/models/user_model.dart';
import 'package:sfe_mobile_app/screens/Auth/authenticate.dart';
import 'package:sfe_mobile_app/screens/home/admin/widgetProviderAdmin.dart';
import 'package:sfe_mobile_app/screens/home/employes/widgetProvider.dart';
import 'package:sfe_mobile_app/services/databaseService.dart';
import 'package:sfe_mobile_app/shared/loading.dart';

class HomeMain extends StatefulWidget {
  @override
  _HomeMainState createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
 
  @override
  Widget build(BuildContext context) {
     final userdata = Provider.of<UserData>(context); 
   return userdata == null ? Auth(): 
      StreamProvider<List<Email>>.value(
      value: DatabaseService().allEmails,
        child: userdata.isAdmin ? WdigetProviderAdmin() : WidgetProvider() ,
    );
  }
}
