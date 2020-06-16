import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfe_mobile_app/models/mail_model.dart';
import 'package:sfe_mobile_app/models/user_model.dart';
import 'package:sfe_mobile_app/services/databaseService.dart';
import 'package:sfe_mobile_app/shared/shared.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';

class SendMailForm extends StatefulWidget {
 final List<Departs> departs;
 SendMailForm({this.departs});
  @override
  _SendMailFormState createState() => _SendMailFormState();
}

class _SendMailFormState extends State<SendMailForm> {

  Color col = Colors.white70;
  final _formKey = GlobalKey<FormState>();

  String _title;
  String _body;
  List<File> _files = [];
  DateTime _dateTime = DateTime.now();
  int del ;
  String traited = "Still";
  String departement ;
  final String dep = "Tous";
  final int dely = 0;
  Map repEmail = {};
  bool _enabled = true;
  bool visiblity = true;
  Widget _pickFile ;
  Widget _sendMail = Text('Envoyer un Courrier' , style: TextStyle(color:Colors.white));
 FocusNode focusNode = FocusNode();
UnfocusDisposition disposition = UnfocusDisposition.scope;
@override
void initState() { 
  super.initState();
  
  focusNode.unfocus(disposition: disposition);
}


  @override
  Widget build(BuildContext context) {

    _pickFile =  FlatButton(
              
              onPressed: ()
              async {
                FocusScope.of(context).unfocus(disposition: disposition);
                _files = await FilePicker.getMultiFile();
               // print("LEN : ${_files.length}");
              },
                        child: Row(
                children: <Widget>[
                  Icon(Icons.attach_file , color: Colors.white,),
                  Text("Choisir un fichier(s)" , style: TextStyle(
                   
                    color: Colors.white
                  ),),
                ],

              ),
              
            );
    


    
    return SingleChildScrollView(
      child: Container(
       
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
                            Text("Envoyer un mail" ,style: TextStyle(
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
              
              SizedBox(height: 20,),
               Padding(
                 padding: const EdgeInsets.all(20.0),
                 child: TextFormField(
           enabled: _enabled,
          style: TextStyle(color:Colors.white70),
          decoration: textInputDeco.copyWith(hintText:"Titre" , hintStyle:TextStyle(color: Colors.white60 , fontSize: 14), 
           prefixIcon: Icon(Icons.title , color:Colors.white54),
          ),
          
          validator: (value)=> value.isEmpty ? "Entre un Titre " : null,
          onChanged: (value)
          {
                  setState(() {
        _title = value;
                  });
          },
        ),
               ),

SizedBox(height: 20,),
             Padding(
               padding: const EdgeInsets.all(20.0),
               child: TextFormField(
                 enabled: _enabled,
                 maxLines: null,
    keyboardType: TextInputType.multiline,
          style: TextStyle(color:Colors.white70),
          decoration: textInputDeco.copyWith(hintText:"Contenu" , hintStyle:TextStyle(color: Colors.white60 , fontSize: 14), 
           prefixIcon: Icon(Icons.subject , color:Colors.white54),
          ),
          
          validator: (value)=> value.isEmpty ? "Entre le contenu " : null,
          onChanged: (value)
          {
                  setState(() {
            _body = value;
           
                  });
          },
        ),
             ),
        SizedBox(height: 20,),
Padding(
                 padding: const EdgeInsets.all(20.0),
                 child: TextFormField(
           enabled: _enabled,
          style: TextStyle(color:Colors.white70),
          decoration: textInputDeco.copyWith(hintText:"Delay par jour" , hintStyle:TextStyle(color: Colors.white60 , fontSize: 14), 
           prefixIcon: Icon(Icons.view_day , color:Colors.white54),
          ),
          
          validator: (value)=> value.isEmpty || int.tryParse(value) == null ? "Entre le delay ou valide delay" : null,
          onChanged: (value)
          {
                  setState(() {
        del = int.parse(value) ?? 0;
                  });
          },
        ),
               ),
       Visibility(
         visible: visiblity,
                child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                  Align(
            
            alignment: Alignment.topLeft,
                    child: Text('Service' , style: TextStyle(
              color:Colors.white70,
              fontSize: 12
            ),),
          ),
           SizedBox(height: 3),
           Container(
             decoration: BoxDecoration(
               color: Colors.white
             ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: DropdownButtonFormField(
                     validator: (val)=> val == null ?  "Veuillez choisir un service " : null,
                
                    
              
                    
                  // style:TextStyle(color: Colors.white70),
                    hint:  Text("Veuillez choisir un service" , style:TextStyle(color: Colors.black87)),
                    value: departement ,
                    items: 
                    widget.departs.map((s){
                        return DropdownMenuItem(
                          value: s.departsName.toString(),
                          child: new Text("${s.departsName}", ),
                          );
                    }).toList(), 
                    onChanged: 
                    (val) {
                        setState(() {
                          departement=val;
                           print(departement.toString());
                        });
                    },
                    
                    
                    ),
                      ),
           ),
              ],
            ),
          ),
       ),
    
        SizedBox(height: 20,),
        ButtonBar(
          children: <Widget>[
              Visibility(
                visible: visiblity,
                child: _pickFile
                ),
            
              FlatButton(
                    child:  _sendMail,
                    onPressed: () async{
                       if(_formKey.currentState.validate())
                  { 
                         setState(() {
                           visiblity = false;
                            _enabled = false;
                        _sendMail =
                         Loading(indicator: BallSpinFadeLoaderIndicator(), size: 30.0,color: Colors.white);
                      });
                      Email email = Email(body: _body , dateRecive: _dateTime.toString() , title:_title , delay: del , department: departement,files: _files, repEmail: repEmail,traited: traited); 
                     try {
                      await DatabaseService().sendMail( _files,email, departement,Provider.of<User>(context,listen : false).uid);
                    
                         setState(() {
                           _sendMail = Row(
                            
                             children: <Widget>[
                               Text('Envoyé' , style: TextStyle(color:Colors.white)),
                               SizedBox(width: 5),
                               Icon(Icons.done_all , color: Colors.white,semanticLabel: "Envoyé"),
                             ],
                           );
                         });
                    
  
                     } catch (e) {
                          setState(() {
                           _sendMail = Row(
                            
                             children: <Widget>[
                               Text('Ne peut pas être envoyé' , style: TextStyle(color:Colors.red)),
                               SizedBox(width: 5),
                               Icon(Icons.cancel , color: Colors.red,semanticLabel: ""),
                             ],
                           );
                         });
                     }
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