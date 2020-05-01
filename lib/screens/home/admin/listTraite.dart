import 'package:provider/provider.dart';
import 'package:sfe_mobile_app/models/mail_model.dart';
import 'package:sfe_mobile_app/screens/home/admin/listAllMails.dart';
import 'package:sfe_mobile_app/services/databaseService.dart';
import 'package:flutter/material.dart';

class TraitedAdmin extends StatelessWidget {
 
 
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Email>>.value(
      value: DatabaseService().allEmailsTraited,
        child:Container(child: ListAllMails()),

      
    );
  }
}