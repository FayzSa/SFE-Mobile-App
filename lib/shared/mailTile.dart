import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfe_mobile_app/models/mail_model.dart';
import 'package:sfe_mobile_app/screens/home/employes/replyForm.dart';
import 'package:sfe_mobile_app/screens/home/employes/showMail.dart';
import 'package:sfe_mobile_app/services/databaseService.dart';
import 'package:timeago/timeago.dart' as timeago;
class MailTile extends StatelessWidget {
  final Email email;
  MailTile({this.email});
  @override
  Widget build(BuildContext context) {
       String _body = email.body.length > 150 ? "${email.body.substring(0,150)}  ... " : email.body ;

         void _showMailPanel()
   {
      showModalBottomSheet(context: context, builder: (context)
      {
        return Scaffold(
          backgroundColor: Colors.black87,
          body: SingleChildScrollView(child: ShowMail(email: email)));
      });
   }
       void _showReplyPanel()
   {

          Navigator.push(context, MaterialPageRoute<Null>(
          builder: (BuildContext context) {
          return Scaffold(body: SingleChildScrollView(child:ReplyForm(email : email)));
          },
          fullscreenDialog: true,
          ));
   }

    // Add a new locale messages
    timeago.setLocaleMessages('fr', timeago.FrMessages());
    Color tileColor = Colors.green[200];
    Widget f ;
    Widget f2;

    if(email.traited != "Not Traited" )
    {
      if(email.repEmail.isEmpty ){
        f2 =                 
                 FlatButton(
                  child:  Text('Reply' , style: TextStyle(color:Colors.black87),),
                  onPressed: () {
                    _showReplyPanel();   
                  },
                );
    }
    }
      if(email.traited == "Still")
      {
        f =  FlatButton(
                  child:  Text('Traite' , style: TextStyle(color:Colors.black87),),
                  onPressed: () {
                    DatabaseService().updateTraited(email);
                  },
                );

     tileColor = Colors.green[200];
      }
      else if(email.traited == "Traited"){
       tileColor = Colors.green[500];
     
      }
      else if(email.traited == "Not Traited"){
        tileColor = Colors.red[400];
  
      }

    return  Padding(
      padding: EdgeInsets.all(2.0),
      child: Card(
        
        elevation: 1.0,
          shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30.0),
  ),
       margin: EdgeInsets.fromLTRB(15, 6, 15, 2),
      child: Column(
         mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 5,),
             ListTile(
               onTap: (){
                 _showMailPanel();
               },
              
              title:   Row(
                     children: <Widget>[
                       CircleAvatar(
              radius: 4.0,
              backgroundColor: tileColor,
                ),
                SizedBox(width: 10),
                Text(email.title , style: TextStyle(
                  color:Colors.black,
                  fontSize: 19,

                ),),
                     ],
                   ),
      
              subtitle: Text(_body),
            ),
            ButtonBar(
              children: <Widget>[
                
                f,
                f2,
                 Text(timeago.format( DateTime.parse(email.dateRecive) , locale: 'fr'),
                style: TextStyle(
                  color:Colors.black54,
                  fontSize: 10
                ),

                ),
                SizedBox(width: 5,)
               
              ],
            ),
           
          ],
        ),
      ),
    );
  }
}

