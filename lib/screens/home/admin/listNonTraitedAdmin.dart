import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfe_mobile_app/models/mail_model.dart';
import 'package:sfe_mobile_app/screens/home/admin/listAllMails.dart';
import 'package:sfe_mobile_app/services/databaseService.dart';

class NonTraitedAdmin extends StatelessWidget {
 
 
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Email>>.value(
      value: DatabaseService().allEmailsNonTraited,
        child:Container(child: ListAllMails()),
    );
  }
}