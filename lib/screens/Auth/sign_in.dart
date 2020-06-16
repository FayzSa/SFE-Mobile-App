import 'package:flutter/material.dart';
import 'package:sfe_mobile_app/services/authService.dart';
import 'package:sfe_mobile_app/shared/loading.dart';
import 'package:sfe_mobile_app/shared/shared.dart';

class SignIn extends StatefulWidget {
  final String error;
   final Function toggleView;
  SignIn({this.toggleView, this.error});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();  
   final _formkey = GlobalKey<FormState>();
  

  // Email filed 
  String email = '';
  String password = '';
  String error= '';

  // loading 
  bool isLoaded = false;


  @override
  Widget build(BuildContext context) {
    if(widget.error!=null)
    {
      setState(() {
        error = widget.error;
      });
    }
    return isLoaded ? Loading() : Container(      
          
        child: Column(
          children: <Widget>[
            Container(
             height:MediaQuery.of(context).size.height/2 - (MediaQuery.of(context).size.height/10),
              width: double.infinity,
                decoration: BoxDecoration(
          
          image: DecorationImage(image: new AssetImage("assets/images/login.png"),
          fit: BoxFit.contain,
          ),
        ),
            ),
            
            SingleChildScrollView(
                  child: Container(
                height: MediaQuery.of(context).size.height/2 + (MediaQuery.of(context).size.height/10),
                decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(80))
                ),
                child: Column(
          children: <Widget>[
        SizedBox(height: 20),
        Text(
          "Se connecter" , style: TextStyle(color:Colors.white , fontWeight: FontWeight.bold, fontSize: 30),
          
          ),  
          SizedBox(height: 10,),
          Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
      key: _formkey,
      child: Column(
      children: <Widget>[
        SizedBox(height:20),
         
        TextFormField(
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
 SizedBox(height: 20,),
         TextFormField(
           
          style: TextStyle(color:Colors.white70 ,fontSize: 17),
          decoration:  textInputDeco.copyWith(hintText:"Mot de passe" , hintStyle:TextStyle(color:Colors.white60,fontSize: 14) , 
           prefixIcon: Icon(Icons.lock , color:Colors.white54),
          ),
             
          
          validator: (value) => value.length < 6 ? "Entre un mot de passe avec plus de 6 caractères " : null,
          obscureText: true,
          onChanged: (value)
          {
        setState(() {
          password = value;
        });
          },
        ),
        SizedBox(height: 20.0,),
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
              dynamic result = await _auth.signInWithEmailAndPassword(email, password);
              if(result==null)
              {
                setState(() {
                  error = "Impossible de se connecter avec ces informations";
                  isLoaded = false;
                });
              
              }
            }
              },
              color: Colors.white,
              
              shape: RoundedRectangleBorder(
  borderRadius: new BorderRadius.circular(18.0),

),
              child: Text("Se connecter" , style: TextStyle(
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
                child: Text("S'inscrire" , style:TextStyle(
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

