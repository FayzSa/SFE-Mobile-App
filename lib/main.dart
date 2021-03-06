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
  color: Colors.black,
  theme: ThemeData(
 
    primaryColor: Colors.black87,
    accentColor: Colors.black,
    


    // Define the default font family.
 

    // Define the default TextTheme. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: TextTheme(
      headline1 : TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold , color: Colors.deepPurple[900]),
      headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic , color: Colors.deepPurple[900]),
      bodyText2 : TextStyle(fontSize: 14.0, fontFamily: 'Hind' , color: Colors.deepPurple[900]),
    ),
  ),
  home: Wrapper(),
      ),
    );
  }
}