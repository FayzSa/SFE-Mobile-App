import 'package:flutter/material.dart';
import 'package:sfe_mobile_app/models/mail_model.dart';
import 'package:sfe_mobile_app/screens/home/admin/showMailAdmin.dart';
import 'package:sfe_mobile_app/screens/home/admin/showReply.dart';
import 'package:timeago/timeago.dart' as timeago;


//MailTileAdmin
class MailTileAdmin extends StatelessWidget {
  final Email email ;
  MailTileAdmin({this.email});


  @override
  Widget build(BuildContext context) {
      String _body = email.body.length > 150 ? "${email.body.substring(0,150)} ... " : email.body ;

 void _showMailPanel()
   {
      showModalBottomSheet(context: context, builder: (context)
      {
        return Scaffold(
          backgroundColor: Colors.black,
          body: SingleChildScrollView(child: ShowMailAdmin(email: email)));
      });
   }

         void _showReplyPanel()
   {
          RepEmail repEmail = RepEmail(
            body:email.repEmail['Body'] ?? "",
            title:email.repEmail['Title'] ?? "",
            files:email.repEmail['Files'] ?? [],
            dateRep:email.repEmail['replayDate'] ?? "",
          );

     showModalBottomSheet(context: context, builder: (context)
      {
        return Scaffold(
          backgroundColor: Colors.black,
          body: SingleChildScrollView(child:ShowReply(repEmail : repEmail , email: email,)));
      });


          

        

   }



    timeago.setLocaleMessages('fr', timeago.FrMessages());
    Widget f ;
    Widget f2;

      Color tileColor = Colors.green[200];

      if(email.traited != "Non Traite" )
    {
      if(email.repEmail.isNotEmpty && email.repEmail["NOTHING"] != "NOTHING"  ){
        f2 =                 
                 FlatButton(
                  child:  Text('Afficher la réponse' , style: TextStyle(color:Colors.black),),
                  onPressed: () {
                    _showReplyPanel();   
                  },
                );
    }
    }
      if(email.traited == "Still")
      {
        tileColor = Colors.green[200];
      }
      else if(email.traited == "Traited"){
        Text('Traited Mail' , style: TextStyle(color:Colors.green[500]));
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
              
              title:   Column(
                children: <Widget>[
                  Row(
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
                       Align(
                         alignment: Alignment.topLeft,
                      child: Text("Service ${email.department}" , style: TextStyle(
                      color:Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w100,

                    ),),
                       ),
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