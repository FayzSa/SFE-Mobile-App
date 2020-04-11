import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfe_mobile_app/models/user_model.dart';
import 'package:sfe_mobile_app/screens/Auth/authenticate.dart';
import 'package:sfe_mobile_app/screens/home/homeRedirect.dart';
import 'package:sfe_mobile_app/shared/loading.dart';

class Wrapper extends StatelessWidget {
Widget _page = null;
  
  @override
  Widget build(BuildContext context) {
  
  final user = Provider.of<User>(context);
    // set Page to Home or auth 
    _page = user == null ? Auth(): HomeRedirect();
    // Loading or go to Auth or Home 
    return _page == null ? Loading() : _page;

  
  }
}