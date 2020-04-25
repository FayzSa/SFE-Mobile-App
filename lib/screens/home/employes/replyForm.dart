import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfe_mobile_app/models/mail_model.dart';
import 'package:sfe_mobile_app/models/user_model.dart';
import 'package:sfe_mobile_app/services/databaseService.dart';
import 'package:sfe_mobile_app/shared/shared.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';

class ReplyForm extends StatefulWidget {
  final Email email ;
  ReplyForm({this.email}); 
  
  @override
  _ReplyFormState createState() => _ReplyFormState();
}

class _ReplyFormState extends State<ReplyForm> {

  
  final _formKey = GlobalKey<FormState>();

  String _title;
  String _body;
  List<File> _files = [];
  DateTime _dateTime = DateTime.now();



  
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

  String _mailID = widget.email.mailID;
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        color:Colors.black87,
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom:15),
                  height: MediaQuery.of(context).size.height/7,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black87,
                     borderRadius: 
                     BorderRadius.only(bottomLeft: Radius.circular(0) ,bottomRight: Radius.circular(80) ),
                  
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: <Widget>[
                            Text("Reply to Mail" ,style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 23
                            ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              SizedBox(height:20),
             
              SizedBox(height: 20,),
               Padding(
                 padding: const EdgeInsets.all(20.0),
                 child: TextFormField(
           
          style: TextStyle(color:Colors.white70),
          decoration: textInputDeco.copyWith(hintText:"Title" , hintStyle:TextStyle(color: Colors.white60 , fontSize: 14), 
           prefixIcon: Icon(Icons.title , color:Colors.white54),
          ),
          
          validator: (value)=> value.isEmpty ? "Entre a Title " : null,
          onChanged: (value)
          {
                  setState(() {
        _title = value;
                  });
          },
        ),
               ),

SizedBox(height: 40,),
             Padding(
               padding: const EdgeInsets.all(20.0),
               child: TextFormField(
                 maxLines: null,
    keyboardType: TextInputType.multiline,
          style: TextStyle(color:Colors.white70),
          decoration: textInputDeco.copyWith(hintText:"Body" , hintStyle:TextStyle(color: Colors.white60 , fontSize: 14), 
           prefixIcon: Icon(Icons.subject , color:Colors.white54),
          ),
          
          validator: (value)=> value.isEmpty ? "Entre some text " : null,
          onChanged: (value)
          {
                  setState(() {
            _body = value;
           
                  });
          },
        ),
             ),
        SizedBox(height: 40,),
        ButtonBar(
          children: <Widget>[
            FlatButton(
              
              onPressed: ()
              async {
                FocusScope.of(context).unfocus(focusPrevious: true);
                _files = await FilePicker.getMultiFile();
               // print("LEN : ${_files.length}");
              },
                        child: Row(
                children: <Widget>[
                  Icon(Icons.attach_file , color: Colors.white,),
                  Text("Pick File" , style: TextStyle(
                   
                    color: Colors.white
                  ),),
                ],

              ),
              
            ),
            
              FlatButton(
                    child:  Text('Send Reply' , style: TextStyle(color:Colors.white),),
                    onPressed: () async{
                       if(_formKey.currentState.validate())
                  { 
                      RepEmail rep = RepEmail(body: _body , dateRep: _dateTime , title:_title); 
                   print(rep.title);
                     await DatabaseService(uid: user.uid).sendRepaly(rep, _mailID, _files);
                         
                      Navigator.pop(context);
                  }
                    },
                  )
          ],
        ),
 
            ],
          )
          
          ),
      ),
    );
  }
}