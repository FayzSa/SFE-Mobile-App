import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfe_mobile_app/models/mail_model.dart';
import 'package:sfe_mobile_app/models/user_model.dart';
import 'package:sfe_mobile_app/screens/home/employes/listMails.dart';

import 'package:sfe_mobile_app/services/databaseService.dart';


class NonTraited extends StatelessWidget {
 
 
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);
    return StreamProvider<List<Email>>.value(
      value: DatabaseService(depRt: user.departement).nonTraitedEmails,
        child:Container(child: ListMails()),

      
    );
  }
}