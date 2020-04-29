import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:sfe_mobile_app/models/mail_model.dart';
import 'package:sfe_mobile_app/screens/Auth/registre.dart';
import 'package:sfe_mobile_app/screens/Auth/sign_in.dart';
import 'package:sfe_mobile_app/shared/loading.dart';


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
    List<Departs> departs =Provider.of<List<Departs>>(context) ?? [];
  departs.removeWhere((item) => item.departsName == 'Tous');
  if(showSignIn)
    {
      return Scaffold(body: SingleChildScrollView(child: SafeArea(child: SignIn(toggleView : toggleView))));
    }
    else{ 
      if(departs.length == 0 ){return Loading();}
      else{
      return
 Scaffold(body: SingleChildScrollView(child: SafeArea(child:Registre(toggleView : toggleView , departs: departs,))));
  }
  }
  }
  }
