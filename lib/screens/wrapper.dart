import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfe_mobile_app/models/mail_model.dart';
import 'package:sfe_mobile_app/models/user_model.dart';
import 'package:sfe_mobile_app/screens/Auth/authenticate.dart';
import 'package:sfe_mobile_app/screens/home/homeRedirect.dart';
import 'package:sfe_mobile_app/services/databaseService.dart';
import 'package:sfe_mobile_app/shared/loading.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  Timer t ;
  Widget _page  = Loading();
  @override
  void initState() { 
    super.initState();
   
    t = Timer(Duration(seconds:5), (){
      setState(() {
        _page = StreamProvider<List<Departs>>.value(
          value: DatabaseService().departments,
          child: Auth());
      });
    });  
  
    
  }

  @override
  Widget build(BuildContext context) {
  
  final user = Provider.of<User>(context);
    setState(() {
  if(user != null) t.cancel(); 
  
    });

  

    // set Page to Home or auth 
    return user == null ? _page : StreamProvider<List<Departs>>.value(
          value: DatabaseService().departments,
          child: HomeRedirect()
          );

   
  }
}