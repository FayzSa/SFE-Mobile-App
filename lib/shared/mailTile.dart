import 'package:flutter/material.dart';
import 'package:sfe_mobile_app/models/mail_model.dart';
import 'package:sfe_mobile_app/services/databaseService.dart';
import 'package:timeago/timeago.dart' as timeago;
class MailTile extends StatelessWidget {
  final Email email;
  MailTile({this.email});
  @override
  Widget build(BuildContext context) {
    // Add a new locale messages
    timeago.setLocaleMessages('fr', timeago.FrMessages());
    Color tileColor = Colors.green[200];
    Widget f ;
    Widget f2;

    if(email.traited != "Not Traited" )
    {
      if(email.repEmail.isEmpty){
        f2 =                 
                 FlatButton(
                  child:  Text('Reply' , style: TextStyle(color:Colors.green[300]),),
                  onPressed: () {/* ... */},
                );
    }
    }
      if(email.traited == "Still")
      {
        f =  FlatButton(
                  child:  Text('Traite' , style: TextStyle(color:Colors.green[300]),),
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
      
              subtitle: Text(email.body),
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


/* child: Container(
         child: Padding(
           padding: const EdgeInsets.all(15.0),
           child: Column(
             children: <Widget>[
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                   Row(
                     children: <Widget>[
                       CircleAvatar(
              radius: 4.0,
              backgroundColor: Colors.green[300],
                ),
                SizedBox(width: 10),
                Text(email.title , style: TextStyle(
                  color:Colors.black,
                  fontSize: 19,

                ),),
                     ],
                   ),
               
                Text(timeago.format(DateTime.parse(email.dateRecive)),
                style: TextStyle(
                  color:Colors.black54,
                  fontSize: 10
                ),

                ),
                
                 ],
               )
             ],
           ),
         ),
       ),
 */