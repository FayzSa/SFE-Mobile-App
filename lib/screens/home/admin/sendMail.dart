import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sfe_mobile_app/models/mail_model.dart';
import 'package:sfe_mobile_app/services/databaseService.dart';
import 'package:sfe_mobile_app/shared/shared.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:material_dropdown_formfield/material_dropdown_formfield.dart';

class SendMailForm extends StatefulWidget {
 
  @override
  _SendMailFormState createState() => _SendMailFormState();
}

class _SendMailFormState extends State<SendMailForm> {

  Color col = Colors.white70;
  final _formKey = GlobalKey<FormState>();
  final List<String> delay = [
  "1","2","3","4","5","6","7","8","9","10",
  "11","12","13","14","15","16","17","18","19","20",
  "21","22","23","24","25","26","27","28","29","30",
  "31","32","33","34","35","36","37","38","39","40",
  "41","42","43","44","45","46","47","48","49","50",
  "51","52","53","54","55","56","57","58","59","60",
  "61","62","63","64","65","66","67","68","69","70",
  "71","72","73","74","75","76","77","78","79","80",
  "81","82","83","84","85","86","87","88","89","90"
  "91","92","93","94","95","96","97","98","99"
  
  ];
  String _title;
  String _body;
  List<File> _files = [];
  DateTime _dateTime = DateTime.now();
  int del ;
  String traited = "Still";
  String department ;
  final String dep = "Tous";
  final int dely = 0;
  Map repEmail = {};
  final List<String> departs = ['Tous','RH','INFO',];
  bool _enabled = true;
  bool visiblity = true;
  Widget _pickFile ;
  Widget _sendMail = Text('Send Mail' , style: TextStyle(color:Colors.white));
 FocusNode focusNode = FocusNode();

@override
void initState() { 
  super.initState();
  focusNode.unfocus(focusPrevious: true);
}

  @override
  Widget build(BuildContext context) {

    _pickFile =  FlatButton(
              
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
                            Text("Send Mail" ,style: TextStyle(
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

SizedBox(height: 20,),
             Padding(
               padding: const EdgeInsets.all(20.0),
               child: TextFormField(
                 enabled: _enabled,
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
        SizedBox(height: 20,),
Padding(
                 padding: const EdgeInsets.all(20.0),
                 child: TextFormField(
           enabled: _enabled,
          style: TextStyle(color:Colors.white70),
          decoration: textInputDeco.copyWith(hintText:"Delay par jour" , hintStyle:TextStyle(color: Colors.white60 , fontSize: 14), 
           prefixIcon: Icon(Icons.view_day , color:Colors.white54),
          ),
          
          validator: (value)=> value.isEmpty || int.tryParse(value) == null ? "Entre a delay or valide delay" : null,
          onChanged: (value)
          {
                  setState(() {
        del = int.parse(value) ?? 0;
                  });
          },
        ),
               ),
      
       Padding(
          padding: const EdgeInsets.all(20.0),
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
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton(
                  focusNode: focusNode,
                  isExpanded: true,
                  
                // style:TextStyle(color: Colors.white70),
                  hint:  Text("Please Choose a Department" , style:TextStyle(color: Colors.black87)),
                  value: department ,
                  items: 
                  departs.map((s){
                      return DropdownMenuItem(
                        value: s.toString(),
                        child: new Text("$s", ),
                        );
                  }).toList(), 
                  onChanged: 
                  (val) {
                      setState(() {
                        department=val;
                         print(department.toString());
                      });
                  }),
                    ),
         ),
            ],
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
                        _sendMail =
                         Loading(indicator: BallSpinFadeLoaderIndicator(), size: 30.0,color: Colors.white);
                      });
                      if(department=='Tous'){
                        department = "ALL";
                      }
                      Email email = Email(body: _body , dateRecive: _dateTime.toString() , title:_title , delay: del , department: department,files: _files, repEmail: repEmail,traited: traited); 
                     await DatabaseService().sendMail( _files,email, department);
                         setState(() {
                            _enabled = false;
                           _sendMail = Row(
                            
                             children: <Widget>[
                               Text('Sent' , style: TextStyle(color:Colors.white)),
                               SizedBox(width: 5),
                               Icon(Icons.done_all , color: Colors.white,semanticLabel: "Sent"),
                             ],
                           );
                         });
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