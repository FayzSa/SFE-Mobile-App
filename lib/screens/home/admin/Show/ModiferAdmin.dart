import "package:flutter/material.dart";
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';
import 'package:sfe_mobile_app/models/user_model.dart';
import 'package:sfe_mobile_app/services/databaseService.dart';
import 'package:sfe_mobile_app/shared/shared.dart';
class ModiferAdmin extends StatefulWidget {
final UserData userDat ; 
ModiferAdmin({this.userDat});
  @override
  _ModiferAdminState createState() => _ModiferAdminState();
}

class _ModiferAdminState extends State<ModiferAdmin> {

   
final _formkey = GlobalKey<FormState>();
String name ;
bool _enabled = true;
final _formKey = GlobalKey<FormState>();

Widget _sendMail = Text('Modifie Admin' , style: TextStyle(color:Colors.white));

  
  @override
  Widget build(BuildContext context) {
      return Container(
       
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
                            Center(
                              child: Text("Modifie Admin" ,style: TextStyle(
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
                   initialValue: widget.userDat.fullName,
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
                     
                     

                     await DatabaseService().updateAdminData(name ?? widget.userDat.fullName,widget.userDat.uid);
                         setState(() {
                           _sendMail = Row(
                            
                             children: <Widget>[
                               Text('Modifie' , style: TextStyle(color:Colors.white)),
                               SizedBox(width: 5),
                               Icon(Icons.done_all , color: Colors.white,semanticLabel: "Modifie"),
                             ],
                           );

                            
                         });
                     
                  }
                    },
                  )
          ],
        ),
 
            ],
          )
          
          ),
      );
  }
}