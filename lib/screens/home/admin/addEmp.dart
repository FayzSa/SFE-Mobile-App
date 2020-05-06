import "package:flutter/material.dart";
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';
import 'package:sfe_mobile_app/models/mail_model.dart';
import 'package:sfe_mobile_app/services/databaseService.dart';
import 'package:sfe_mobile_app/shared/shared.dart';
class AddEmp extends StatefulWidget {
  final List<Departs> deparemtens ;
  AddEmp({this.deparemtens});

  @override
  _AddEmpState createState() => _AddEmpState();
}

class _AddEmpState extends State<AddEmp> {

  
  final _formkey = GlobalKey<FormState>();

  // Email filed 
  String email = '';
  String password = '';
  String name = "";
  String depart ;
  String grade = "";
  String error= '';
  bool _enabled = true;

  final _formKey = GlobalKey<FormState>();


    Widget _sendMail = Text('Add Personel' , style: TextStyle(color:Colors.white));

  
  @override
  Widget build(BuildContext context) {
widget.deparemtens.removeWhere((item) => item.departsName == 'Tous');
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
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: <Widget>[
                            
                            SizedBox(height: 20,),
                            Center(
                              child: Text("Ajouter Personel" ,style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 23
                              ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
         
               Padding(
                 padding: const EdgeInsets.all(10.0),
                 child: TextFormField(
                   
        enabled: _enabled,
        style: TextStyle(color:Colors.white70),
        decoration: textInputDeco.copyWith(hintText:"Nom Complete" , hintStyle:TextStyle(color: Colors.white60 , fontSize: 14), 
         prefixIcon: Icon(Icons.face , color:Colors.white54),
        ),
        
        validator: (value)=> value.isEmpty ? "Tapez Le Nom Complete " : null,
        onChanged: (value)
        {
              setState(() {
      name = value;
              });
        },
      ),
               ),


               Padding(
                 padding: const EdgeInsets.all(10.0),
                 child: TextFormField(
                   
        enabled: _enabled,
        style: TextStyle(color:Colors.white70),
        decoration: textInputDeco.copyWith(hintText:"Grade" , hintStyle:TextStyle(color: Colors.white60 , fontSize: 14), 
         prefixIcon: Icon(Icons.grade , color:Colors.white54),
        ),
        
        validator: (value)=> value.isEmpty ? "Tapez Le Grade " : null,
        onChanged: (value)
        {
              setState(() {
      grade = value;
              });
        },
      ),
               ),
SizedBox(height: 10,),
             Padding(
               padding: const EdgeInsets.all(10.0),
               child: TextFormField(
                 
        enabled: _enabled,
        style: TextStyle(color:Colors.white70),
        decoration: textInputDeco.copyWith(hintText:"E-Mail" , hintStyle:TextStyle(color: Colors.white60 , fontSize: 14), 
         prefixIcon: Icon(Icons.mail , color:Colors.white54),
        ),
        
        validator: (value)=> value.isEmpty ? "Entre an email " : null,
        onChanged: (value)
        {
              setState(() {
      email = value;
              });
        },
      ),
             ),



             Padding(
               padding: const EdgeInsets.all(10.0),
               child: TextFormField(
         
        style: TextStyle(color:Colors.white70 ,fontSize: 17),
        decoration:  textInputDeco.copyWith(hintText:"Password" , hintStyle:TextStyle(color:Colors.white60,fontSize: 14) , 
         prefixIcon: Icon(Icons.lock , color:Colors.white54),
        ),
           
        enabled: _enabled,
        validator: (value) => value.length < 6 ? "Entre an password with more than 6 chars " : null,
        obscureText: true,
        onChanged: (value)
        {
      setState(() {
        password = value;
      });
        },
      ),
             ),

   SizedBox(height: 10,),




       Padding(
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
                      child: Visibility(
                        visible: _enabled,
                   child: DropdownButtonFormField(
                   validator: (val)=> val == null ?  "Please Choose a Service " : null,
                  hint:  Text("Please Choose a Service" , style:TextStyle(color: Colors.black87)),
                  value: depart,
                  items: 
                  widget.deparemtens.map((s){
                        return DropdownMenuItem(
                          value: s.departsName.toString(),
                          child: new Text("${s.departsName}", ),
                          );
                  }).toList(), 
                  onChanged: 
                  (val) {
                        setState(() {
                          depart=val.toString();
                          
                        });
                  },
                  
                  
                  ),
                      ),
                    ),
         ),
            ],
          ),
        ),
    
     
     
        SizedBox(height: 10,),
        ButtonBar(
          children: <Widget>[
            
              FlatButton(
                    child:  _sendMail,
                    onPressed: () async{
                       if(_formKey.currentState.validate())
                  { 
                         setState(() {
                         
                            _enabled = false;
                        _sendMail =
                         Loading(indicator: BallSpinFadeLoaderIndicator(), size: 30.0,color: Colors.white);
                      });
                     
                     try {
                       await DatabaseService().addUsers(email, password, depart ,name, false, grade:grade);
                         setState(() {
                           _sendMail = Row(
                            
                             children: <Widget>[
                               Text('Added' , style: TextStyle(color:Colors.white)),
                               SizedBox(width: 5),
                               Icon(Icons.done_all , color: Colors.white,semanticLabel: "Added"),
                             ],
                           );
                         });
                     } catch (e) {
                         setState(() {
                           _sendMail = Row(
                            
                             children: <Widget>[
                               Text('Can not Add' , style: TextStyle(color:Colors.red)),
                               SizedBox(width: 5),
                               Icon(Icons.cancel , color: Colors.red,semanticLabel: "Added"),
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