import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfe_mobile_app/models/user_model.dart';
import 'package:sfe_mobile_app/screens/wrapper.dart';
import 'package:sfe_mobile_app/services/authService.dart';

void main(){
  runApp(MailGest());
}


class MailGest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: "Gestion Courrier",
        debugShowCheckedModeBanner: false,
        color: Colors.teal[700],
        theme: ThemeData(
          primaryColor: Colors.teal[700],
        ),
        home: Wrapper(),
      ),
    );
  }
}