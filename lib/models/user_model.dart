
import 'package:sfe_mobile_app/models/mail_model.dart';

class User
{
  final String uid ;
  User({this.uid});

}


class UserData
{

  final String uid,fullName,departement;
  final bool isAdmin;
  List<Email> recivedMails; 
  UserData({this.uid,this.fullName,this.departement,this.isAdmin , this.recivedMails}); 
  
}

