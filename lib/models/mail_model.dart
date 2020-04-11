class Email
{
  String mailID;
  String title;
  String body ; 
  DateTime dateRecive ; 
  List<String> files; 
  String traited;
  Map repEmail;
  Email({this.mailID,this.title , this.body , this.dateRecive , this.files , this.traited ,this.repEmail });
}

class RepEmail 
{
  String title;
  String body ; 
  DateTime dateRep ; 
  List<String> files; 
  RepEmail({this.title , this.body , this.dateRep , this.files  });
}
