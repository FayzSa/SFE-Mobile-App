import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:sfe_mobile_app/screens/home/admin/mainAdmin.dart';

class WdigetProviderAdmin extends StatefulWidget {
  @override
  _WdigetProviderAdminState createState() => _WdigetProviderAdminState();
}

class _WdigetProviderAdminState extends State<WdigetProviderAdmin> {
   GlobalKey _bottomNavigationKey = GlobalKey();

Widget _headerText = Text("All Mails");

Widget _showPage = MainAdmin();
  Widget _choosenPage(int index){
     if(index == 0) return MainAdmin();
     //if(index == 1) return _SendNewMail;
     //if(index == 2) return _;
     //if(index == 3) return _aboutDe;
     else {
       return Scaffold(
         backgroundColor: Colors.white,
         body: Container(
           padding: EdgeInsets.all(50),
           child:Center(child: Text("There's No Selected Page !!"))
         ),

       );
     }
   }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 50.0,
          items: <Widget>[
            Icon(Icons.insert_chart, size: 25,color: Colors.white, ),
            Icon(Icons.call, size: 25,color: Colors.white,),
            Icon(Icons.help, size: 25,color: Colors.white,),
            Icon(Icons.info, size: 25,color: Colors.white,),
            
            ],
          color: Colors.deepPurple[900],
          buttonBackgroundColor: Colors.deepPurple[900],
          backgroundColor: Colors.transparent,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
          
            setState(() {
              _showPage = _choosenPage(index);
            });
             
              },
          
        ),
        body:  Container(child: _showPage)
          
        
    );
  }
}