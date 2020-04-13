import "package:flutter/material.dart";
import 'package:sfe_mobile_app/screens/Auth/registre.dart';
import 'package:sfe_mobile_app/screens/Auth/sign_in.dart';


class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {

    bool showSignIn = true ; 
  void toggleView()
  {
    setState(() =>
      showSignIn = !showSignIn
    );
  }
  @override
  Widget build(BuildContext context) {
  if(showSignIn)
    {
      return SignIn(toggleView : toggleView);
    }
    else return Registre(toggleView : toggleView);
  }
  }
