import 'package:flutter/material.dart';
import 'package:sfe_mobile_app/models/mail_model.dart';
import 'package:sfe_mobile_app/services/authService.dart';
import 'package:sfe_mobile_app/shared/loading.dart';
import 'package:sfe_mobile_app/shared/shared.dart';

class Registre extends StatefulWidget {
   final Function toggleView;
   final List<Departs> departs;
  Registre({this.toggleView , this.departs});

  @override
  _RegistreState createState() => _RegistreState();
}

class _RegistreState extends State<Registre> {


  final AuthService _auth = AuthService();  
  final _formkey = GlobalKey<FormState>();
  // Email filed 
  String email = '';
  String password = '';
  String name = "";
  String error= '';
  String departement ;

  // loading 
  bool isLoaded = false;

 FocusNode focusNode = FocusNode();
@override
void initState() { 
  super.initState();
   focusNode.unfocus(focusPrevious: true);
}

  @override
  Widget build(BuildContext context) {
    
 
    return isLoaded ? Loading() :  Container(
      child: Column(
        children: <Widget>[
          Container(
           height:MediaQuery.of(context).size.height/2 - (MediaQuery.of(context).size.height/6),
            width: double.infinity,
              decoration: BoxDecoration(
        
        image: DecorationImage(image: new AssetImage("assets/images/undraw_messenger_e7iu.png"),
        fit: BoxFit.fill,
        ),
      ),
          ),
          
          SingleChildScrollView(
                child: Container(
            //  height: MediaQuery.of(context).size.height/2 + (MediaQuery.of(context).size.height/6),
              decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(80))
              ),
              child: Column(
        children: <Widget>[
      SizedBox(height: 15),
      Text(
        "Registre" , style: TextStyle(color:Colors.white , fontWeight: FontWeight.bold, fontSize: 30),
        
        ),  
        SizedBox(height: 5,),
        Padding(
      padding: const EdgeInsets.all(10.0),
      child: Form(
      key: _formkey,
      child: Column(
      children: <Widget>[
      SizedBox(height:15),
      TextFormField(
        style: TextStyle(color:Colors.white70),
        decoration: textInputDeco.copyWith(hintText:"Nom Complete" , hintStyle:TextStyle(color: Colors.white60 , fontSize: 14), 
         prefixIcon: Icon(Icons.face , color:Colors.white54),
        ),
        
        validator: (value)=> value.isEmpty ? "Tapez Votre Nom " : null,
        onChanged: (value)
        {
              setState(() {
      name = value;
              });
        },
      ),
 SizedBox(height: 15,),
       
      TextFormField(
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
 SizedBox(height: 15,),
       TextFormField(
         
        style: TextStyle(color:Colors.white70 ,fontSize: 17),
        decoration:  textInputDeco.copyWith(hintText:"Password" , hintStyle:TextStyle(color:Colors.white60,fontSize: 14) , 
         prefixIcon: Icon(Icons.lock , color:Colors.white54),
        ),
           
        
        validator: (value) => value.length < 6 ? "Entre an password with more than 6 chars " : null,
        obscureText: true,
        onChanged: (value)
        {
      setState(() {
        password = value;
      });
        },
      ),
      SizedBox(height: 5.0,),

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
                      child: DropdownButtonFormField(
                   validator: (val)=> val == null ?  "Please Choose a Service " : null,
              
                  
            
                  
                // style:TextStyle(color: Colors.white70),
                  hint:  Text("Please Choose a Service" , style:TextStyle(color: Colors.black87)),
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
    
      SizedBox(height: 15.0,),
      Padding(
        
        padding: const EdgeInsets.only(left :35.0 , right: 35.0),
        child: SizedBox(
          width: double.infinity/2,
          height: MediaQuery.of(context).size.height/19,
          child: RaisedButton(
            
            onPressed: ()async
            {
       if(_formkey.currentState.validate())
          {
             setState(() {
                  isLoaded = true;
                });
            dynamic result = await _auth.registreWithEmailAndPassword(email, password, departement , name ,false);
            if(result==null)
            {
              setState(() {
                error = "Could not Registre in with those informations";
                isLoaded = false;
              });
            
            }
          }
            },
            color: Colors.white,
            
            shape: RoundedRectangleBorder(
  borderRadius: new BorderRadius.circular(18.0),

),
            child: Text("Registre" , style: TextStyle(
      color:Colors.black87
            ),),
            ),
        ),
      ),
       // SizedBox(height: 10.0),
        
          Text(error, style:TextStyle(color: Colors.red[400], fontSize: 14)),
          FlatButton(
              onPressed:()
              {
      widget.toggleView();
              },
              
              color: Colors.transparent,
              child: Text("Sign In" , style:TextStyle(
      color:Colors.white,
      fontWeight: FontWeight.bold
              )),
        ),
      ],
      )),
        ),
        ],
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}









//                        dynamic result = await _auth.registreWithEmailAndPassword(email, password,"RH" , "Fayz" );
