import 'package:flutter/material.dart';
import 'package:sfe_mobile_app/services/authService.dart';
import 'package:sfe_mobile_app/shared/loading.dart';
import 'package:sfe_mobile_app/shared/shared.dart';

class Registre extends StatefulWidget {
   final Function toggleView;
  Registre({this.toggleView});
  @override
  _RegistreState createState() => _RegistreState();
}

class _RegistreState extends State<Registre> {


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
  final width = MediaQuery.of(context).size.width;
    return isLoaded ? Loading() : Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: <Widget>[
                Flexible(
                  fit: FlexFit.loose,
                  child: Container(
                    height: 400,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: -30,
                          height: 400,
                          width:width,
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/registre.png"),
                                fit: BoxFit.fill 
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Padding(padding: EdgeInsets.all(40),
                child: Column(
                  children: <Widget>[
                    Text(
                  "Registre" , style: TextStyle(color:Colors.grey[400] , fontWeight: FontWeight.bold, fontSize: 30),
                  ),  
                  SizedBox(height: 40,),
                  Form(
          key: _formkey,
          child: Column(
          children: <Widget>[
            SizedBox(height:20),
            TextFormField(
              decoration: textInputDeco.copyWith(hintText:"E-Mail"),
              
              validator: (value)=> value.isEmpty ? "Entre an email " : null,
              onChanged: (value)
              {
                setState(() {
                  email = value;
                });
              },
            ),
             SizedBox(height:20),

             TextFormField(
               decoration: textInputDeco.copyWith(hintText:"Password"),
              
              validator: (value) => value.length < 6 ? "Entre an password with more than 6 chars " : null,
              obscureText: true,
              onChanged: (value)
              {
                  setState(() {
                    password = value;
                  });
              },
            ),
            SizedBox(height: 20.0,),
            RaisedButton(
              onPressed: ()async
              {
                 if(_formkey.currentState.validate())
                  {
                     setState(() {
                          isLoaded = true;
                        });
                    dynamic result = await _auth.registreWithEmailAndPassword(email, password,"RH" , "Fayz" );
                    if(result==null)
                    {
                      setState(() {
                        error = "Please supply a valid Email ";
                        isLoaded = false;
                      });
                    
                    }
                  }
              },
              color: Colors.teal[700],
              child: Text("Registre" , style: TextStyle(
                color:Colors.white
              ),),
              ),
              SizedBox(height: 20.0),
               RaisedButton(
                onPressed:()
                {
                  widget.toggleView();
                },
                color: Colors.transparent,
                child: Text("Sign-In" , style:TextStyle(
                  color:Colors.grey,
                  fontWeight: FontWeight.bold
                )),
              ),
              Text(error, style:TextStyle(color: Colors.red, fontSize: 14)),
          ],
        )),
                  ],
                ),
                ),
                
              ],
            ),
          );
  }
}