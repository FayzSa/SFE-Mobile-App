import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfe_mobile_app/models/mail_model.dart';
import 'package:sfe_mobile_app/screens/home/admin/listAllMails.dart';
import 'package:sfe_mobile_app/services/databaseService.dart';


class MainAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //All mails 
    return Container(
      child: ListAllMails(),
    );
  }
}