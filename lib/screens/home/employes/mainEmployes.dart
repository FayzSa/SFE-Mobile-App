import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfe_mobile_app/models/mail_model.dart';
import 'package:sfe_mobile_app/models/user_model.dart';
import 'package:sfe_mobile_app/services/authService.dart';
import 'package:sfe_mobile_app/services/databaseService.dart';

class MainEmployes extends StatelessWidget {
  // This will be Use to logout
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);
    return StreamProvider<List<Email>>.value(
      value: DatabaseService(uid: user.uid).emails,
    );
  }
}