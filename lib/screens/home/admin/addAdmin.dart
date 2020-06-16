import "package:flutter/material.dart";
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';
import 'package:sfe_mobile_app/services/databaseService.dart';
import 'package:sfe_mobile_app/shared/shared.dart';
class AddAdmin extends StatefulWidget {
  @override
  _AddAdminState createState() => _AddAdminState();
}

class _AddAdminState extends State<AddAdmin> {

   
  final _formkey = GlobalKey<FormState>();

  // Email filed 
  String email = '';
  String password = '';
  String name = "";
  String error= '';
  bool _enabled = true;

  final _formKey = GlobalKey<FormState>();
Widget fs ;


    Widget _sendMail = Text('Ajouter Admin' , style: TextStyle(color:Colors.white));

  
  @override
  Widget build(BuildContext context) {

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
                              child: Text("Ajouter Admin" ,style: TextStyle(
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

SizedBox(height: 10,),
             Padding(
               padding: const EdgeInsets.all(10.0),
               child: TextFormField(
                 
        enabled: _enabled,
        style: TextStyle(color:Colors.white70),
        decoration: textInputDeco.copyWith(hintText:"E-Mail" , hintStyle:TextStyle(color: Colors.white60 , fontSize: 14), 
         prefixIcon: Icon(Icons.mail , color:Colors.white54),
        ),
        
        validator: (value)=> value.isEmpty ? "Entre un e-mail " : null,
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
        decoration:  textInputDeco.copyWith(hintText:"Mot de passe" , hintStyle:TextStyle(color:Colors.white60,fontSize: 14) , 
         prefixIcon: Icon(Icons.lock , color:Colors.white54),
        ),
           
        enabled: _enabled,
        validator: (value) => value.length < 6 ? "Entre un mot de passe avec plus de 6 caractères " : null,
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
                       await DatabaseService().addUsers(email, password, null, name, true);
                         setState(() {
                            _enabled = false;
                           _sendMail = Row(
                            
                             children: <Widget>[
                               Text('Ajouté' , style: TextStyle(color:Colors.white)),
                               SizedBox(width: 5),
                               Icon(Icons.done_all , color: Colors.white,semanticLabel: "Ajouté"),
                             ],
                           );
                         });
                     
                       
                     } catch (e) {
                                 setState(() {
                            _enabled = false;
                           _sendMail = Row(
                            
                             children: <Widget>[
                               Text("Impossible d'ajouter" , style: TextStyle(color:Colors.red)),
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