import 'package:flutter/material.dart';
import 'package:sfe_mobile_app/models/mail_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timeago/timeago.dart' as timeago;

class ShowReply extends StatefulWidget {
  final RepEmail repEmail;
  final Email email;
  ShowReply({this.repEmail , this.email});
  @override
  _ShowReplyState createState() => _ShowReplyState();
}

class _ShowReplyState extends State<ShowReply> {
  
  @override
  Widget build(BuildContext context) {
      Color tileColor = Colors.green[500];

    int count =widget.repEmail.files == null ? 0 : widget.repEmail.files.length;
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
                        Column(
                          children: <Widget>[
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
                                  Text(widget.repEmail.title ,style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 23,
                            ),
                            ),
                                ],
                              ),
                            Text(timeago.format( DateTime.parse(widget.repEmail.dateRep) , locale: 'fr'),
              style: TextStyle(
                color:Colors.white70,
                fontSize: 10
              ),
              ),
                            ],
                            ),
                            Text("Department : ${widget.email.department}" , style: TextStyle(
                      color:Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w100,

                    ),),
                          ],
                          
                        ),
                        SizedBox(height: 20,),
                        Text(widget.repEmail.body, style: TextStyle(
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
              child: Text("Download" , style:TextStyle(
            color:Colors.white60,
            
              )
              ),
      ),
          );//MailTile(email: widget.email.files[index]);
           }
       
       
       
       ),
       SizedBox(height:10),
         
      
                      ],
                    ),
                  ),
                ],
              ),
            ),
     
         
      
 
        ],
      ),
    );
 
  }
}