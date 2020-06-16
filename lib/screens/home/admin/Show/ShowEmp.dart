import "package:flutter/material.dart";
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';
import 'package:sfe_mobile_app/models/mail_model.dart';
import 'package:sfe_mobile_app/models/user_model.dart';
import 'package:sfe_mobile_app/services/databaseService.dart';
import 'package:sfe_mobile_app/shared/shared.dart';
class ShowEmp extends StatefulWidget {
  final List<Departs> deparemtens ;
  final UserData userData;
  ShowEmp({this.deparemtens , this.userData});

  @override
  _ShowEmpState createState() => _ShowEmpState();
}

class _ShowEmpState extends State<ShowEmp> {

   
  final _formkey = GlobalKey<FormState>();

  // Email filed 
  String name ;
 
  String grade ;
  String error= '';
  bool _enabled = true;

  final _formKey = GlobalKey<FormState>();


    Widget _sendMail = Text('Modifer Personel' , style: TextStyle(color:Colors.white));

  
  @override
  Widget build(BuildContext context) {
  
    List<Departs> departs = widget.deparemtens;
  departs.removeWhere((item) => item.departsName == 'Tous');
  String depart = widget.userData.departement;

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
                              child: Text("Modifier Personel" ,style: TextStyle(
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
                   initialValue: widget.userData.fullName ?? "Unknown",
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
        initialValue: widget.userData.grade ?? "Unknown",
        style: TextStyle(color:Colors.white70),
        decoration: textInputDeco.copyWith(hintText:"Grade" , hintStyle:TextStyle(color: Colors.white60 , fontSize: 14), 
         prefixIcon: Icon(Icons.grade, color:Colors.white54),
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
                          
                   validator: (val)=> val == null ?  "Veuillez choisir un service " : null,
                  hint:  Text("Veuillez choisir un service" , style:TextStyle(color: Colors.black87)),
                  value: depart ?? (widget.userData.departement ?? " ") ,
                  items: 
                  departs.map((s){
                        return DropdownMenuItem(
                          value: s.departsName.toString(),
                          child: new Text("${s.departsName}", ),
                          );
                  }).toList(), 
                  onChanged: 
                  (val) {
                        setState(() {
                          depart=val.toString();
                           print(depart.toString());
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
                     
                     

                     await DatabaseService().updateUserData(name ?? widget.userData.fullName, depart ?? widget.userData, false, widget.userData.uid , grade: grade ?? widget.userData.grade);
                         setState(() {
                            _enabled = false;
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
      ),
    );
  }
}