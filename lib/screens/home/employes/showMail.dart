import 'package:flutter/material.dart';
import 'package:sfe_mobile_app/models/mail_model.dart';
import 'package:sfe_mobile_app/screens/home/employes/replyForm.dart';
import 'package:sfe_mobile_app/services/databaseService.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';
class ShowMail extends StatefulWidget {
  final Email email ;
  ShowMail({this.email});
  @override
  _ShowMailState createState() => _ShowMailState();
}

class _ShowMailState extends State<ShowMail> {
  
  @override
  Widget build(BuildContext context) {

    int count =widget.email.files == null ? 0 : widget.email.files.length;


          void _showReplyPanel()
   {

            Navigator.push(context, MaterialPageRoute<Null>(
          builder: (BuildContext context) {
          return Scaffold(body: SingleChildScrollView(child:ReplyForm(email :widget.email)));
          },
          fullscreenDialog: true,
        ));


    
   }


    timeago.setLocaleMessages('fr', timeago.FrMessages());
    Widget f ;
    Widget f2;

      Color tileColor = Colors.green[200];

       if(widget.email.traited != "Not Traited" )
    {
      if(widget.email.repEmail.isEmpty  ){
        f2 =                 
                 FlatButton(
                  child:  Text('Réponse' , style: TextStyle(color:Colors.white),),
                  onPressed: () {
                    _showReplyPanel();   
                  },
                );
    }
    }
      if(widget.email.traited == "Still")
      {
        f =  FlatButton(
                  child:  Text('Traite' , style: TextStyle(color:Colors.white),),
                  onPressed: () {
                    DatabaseService().updateTraited(widget.email);
                  },
                );
        tileColor = Colors.green[200];
      }
      else if(widget.email.traited == "Traited"){
       tileColor = Colors.green[500];
     
      }
      else if(widget.email.traited == "Not Traited"){
        tileColor = Colors.red[400];
  
      }

    return SingleChildScrollView(
          child: Column(
        children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom:15),
            
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                          
                          Row(
                            children: <Widget>[
                                CircleAvatar(
                                radius: 4.0,
                                backgroundColor: tileColor,
                                  ),
                                  SizedBox(width: 10),
                              Text(widget.email.title ,style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 23,
                        ),
                        ),
                            ],
                          ),
                        Text(timeago.format( DateTime.parse(widget.email.dateRecive) , locale: 'fr'),
              style: TextStyle(
                color:Colors.white70,
                fontSize: 10
              ),
              ),
                        ],
                        ),
                        SizedBox(height: 20,),
                        Text(widget.email.body, style: TextStyle(
                          color:Colors.white70,
                          fontSize: 14,

                        ),
                        ),

                  SizedBox(height: 10,),
                     Align(
                       alignment: Alignment.topLeft,
                            child: Text("Attachment", style: TextStyle(
                            color:Colors.white70,
                            fontSize: 14,

                          ),
                          ),
                     ),     
       ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
            itemCount: count,
            itemBuilder: (context ,index)
             {
          return  Padding(
            padding: const EdgeInsets.only(left:8,top: 2,right: 8, bottom: 5),
            child: FlatButton(
              
            
              onPressed:()
              async {
                 String url = widget.email.files[index];
                  if (await canLaunch(url)) {
                  await launch(url);
                }
                 else {
                  throw 'Could not launch $url';
                }
              },
              
              color: Colors.black87,
              child: Text("Télécharger" , style:TextStyle(
            color:Colors.white60,
            
              )
              ),
      ),
          );//MailTile(email: widget.email.files[index]);
           }
       
       
       
       ),
       SizedBox(height:10),
         
      
       ButtonBar(
       children: <Widget>[
       f,
       f2,
       ],
       )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(height:10),
         
      
 
        ],
      ),
    );
  }
}