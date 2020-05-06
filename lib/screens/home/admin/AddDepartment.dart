import "package:flutter/material.dart";
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';
import 'package:sfe_mobile_app/services/databaseService.dart';
import 'package:sfe_mobile_app/shared/shared.dart';
class AddDep extends StatefulWidget {

  @override
  _AddDepState createState() => _AddDepState();
}

class _AddDepState extends State<AddDep> {

   
final _formkey = GlobalKey<FormState>();
String dep ;
bool _enabled = true;
final _formKey = GlobalKey<FormState>();
String error = '';

Widget _sendMail = Text('Add Service' , style: TextStyle(color:Colors.white));
Widget _loading =  Loading(indicator: BallSpinFadeLoaderIndicator(), size: 30.0,color: Colors.white);
  
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
                            Center(
                              child: Text("Ajouter Service" ,style: TextStyle(
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
        decoration: textInputDeco.copyWith(hintText:"Nom De Service" , hintStyle:TextStyle(color: Colors.white60 , fontSize: 14), 
         prefixIcon: Icon(Icons.business , color:Colors.white54),
        ),
        
        validator: (value)=> value.isEmpty ? "Tapez Le Nom De Service " : null,
        onChanged: (value)
        {
              setState(() {
      dep = value;
              });
        },
      ),
               ),


        SizedBox(height: 10,),
        ButtonBar(
          children: <Widget>[
            Text(error,style: TextStyle(
              color:Colors.red[500]
            ),),
              FlatButton(
                    child:  _sendMail,
                    onPressed: () async{
                       if(_formKey.currentState.validate())
                  { 
                          setState(() {
                            _enabled = false;
                        _sendMail =
                        Text(" ... ",style: TextStyle(color: Colors.white60 ),);
                      });
                     
                     try {
                 

                     await DatabaseService().addDeprt(dep);
                         setState(() {
                            _enabled = false;
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
                            _enabled = false;
                           _sendMail = Row(
                            
                             children: <Widget>[
                               Text('Can not add' , style: TextStyle(color:Colors.red)),
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