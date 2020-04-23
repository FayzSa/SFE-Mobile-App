import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sfe_mobile_app/models/mail_model.dart';
import 'package:sfe_mobile_app/services/databaseService.dart';
import 'package:loading/loading.dart';
import 'package:sfe_mobile_app/shared/mailTile.dart';

class ListMails extends StatefulWidget {

  @override
  _ListMailsState createState() => _ListMailsState();
}
Color buttonColor = Colors.black;
class _ListMailsState extends State<ListMails> {
 
     //Widget buttonSendChild = Text("Send Mail" , style: TextStyle(color:Colors.white,));
 List<Email> listOfEmails;

   @override
  Widget build(BuildContext context) {
    final  emails = Provider.of<List<Email>>(context) ?? []; 
     return emails.length == 0 ? Center(child: Text("You have No Email",
     style: TextStyle(
       color:Colors.black87,

     ),
     
     ),): ListView.builder(
     
       itemCount: emails.length,
       itemBuilder: (context ,index)
       {
         return MailTile(email: emails[index]);
       }
       
       
       
     );}
}



/*
return Container(
       child: Column(
         children: <Widget>[
           RaisedButton(onPressed: () async{

             setState(() {
               buttonSendChild = Loading(indicator: BallSpinFadeLoaderIndicator(), size: 30.0,color: Colors.white);
             });

            Email em = Email(body: "Fayz" , dateRecive: DateTime.now().toString() , files: [] , title: "Fatzz" , traited: "Still"  );
            await DatabaseService().sendMail([],em,"RH");
            setState(() {
              buttonColor = Colors.green;
              buttonSendChild = Icon(Icons.done_all , color: Colors.white,semanticLabel: "Sent");
            });
            
           },
           child: buttonSendChild,
           color: buttonColor,
           )
         ],
       ),
     );
      
    */