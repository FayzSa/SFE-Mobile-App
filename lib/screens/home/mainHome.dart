import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfe_mobile_app/models/user_model.dart';
import 'package:sfe_mobile_app/screens/Auth/authenticate.dart';
import 'package:sfe_mobile_app/screens/home/admin/widgetProviderAdmin.dart';
import 'package:sfe_mobile_app/screens/home/employes/widgetProvider.dart';
import 'package:sfe_mobile_app/shared/loading.dart';

class HomeMain extends StatefulWidget {
  @override
  _HomeMainState createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  Widget _page = Loading();
  @override
  void initState() { 
    super.initState();
    Timer(Duration(seconds: 10), (){

        setState(() {
          _page = Auth();
        });

    });
  }
  @override
  Widget build(BuildContext context) {
     final userdata = Provider.of<UserData>(context); 
   return userdata == null ? _page: 
       SafeArea(
        child: userdata.isAdmin ? WdigetProviderAdmin() : WidgetProvider() ,
    );
  }
}
/*
class HomeMain extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    
    final userdata = Provider.of<UserData>(context); 
    return userdata == null ? Auth(): 
       SafeArea(
        child: userdata.isAdmin ? MainAdmin() : WidgetProvider() ,
    );
  }
}*/