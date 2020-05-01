import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfe_mobile_app/models/mail_model.dart';
import 'package:sfe_mobile_app/screens/home/admin/mainAdmin.dart';
import 'package:sfe_mobile_app/screens/home/admin/sendMail.dart';
import 'package:sfe_mobile_app/screens/home/admin/settings.dart';
import 'package:sfe_mobile_app/services/authService.dart';
import 'package:sfe_mobile_app/shared/loading.dart';

class WdigetProviderAdmin extends StatefulWidget {
  @override
  _WdigetProviderAdminState createState() => _WdigetProviderAdminState();
}

class _WdigetProviderAdminState extends State<WdigetProviderAdmin> {
   GlobalKey _bottomNavigationKey = GlobalKey();
        void _sendMailPanel(List<Departs> dep)
   {

            Navigator.push(context, MaterialPageRoute<Null>(
          builder: (BuildContext context) {
          return Scaffold(
            backgroundColor: Colors.black87,
            body: SingleChildScrollView(child:SendMailForm(departs: dep,) ));
          },
          fullscreenDialog: true,
        ));


    
   }
String _headerText = "All Mails";

Widget _showPage = MainAdmin();
  Widget _choosenPage(int index){
     if(index == 0) return MainAdmin();
     //if(index == 1) return _SendNewMail;
     if(index == 2) return Settings();
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

    final departs =Provider.of<List<Departs>>(context) ?? [];
   return Scaffold(
           floatingActionButton: FloatingActionButton(
             
        onPressed:(){
          setState(() {
          _sendMailPanel(departs);
          });
          },
        backgroundColor: Colors.black,
        child: Icon(Icons.send),        
        ),
      bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 50.0,
          items: <Widget>[
            Icon(Icons.email, size: 25,color: Colors.white, ),
            Icon(Icons.filter_list, size: 25,color: Colors.white,),
            Icon(Icons.settings, size: 25,color: Colors.white,),
            Icon(Icons.exit_to_app, size: 25,color: Colors.white),
            
            ],
          color: Colors.black,
          buttonBackgroundColor: Colors.black,
          backgroundColor: Colors.white,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            
            if(index == 3){
              setState(() async{
              _showPage =  Loading();
              await AuthService().signOut();
                
              });
            }
          
            setState(() {
              if(index == 0) _headerText = "All Mails";
              if(index == 1) _headerText = "Filters";
              if(index == 2) _headerText = "Settings";
              _showPage = _choosenPage(index);
            });
             
              },
          
        ),
        body: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom:15),
                  height: MediaQuery.of(context).size.height/7,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black,
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
                            Text(_headerText ,style: TextStyle(
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
                ), // header
              //  SizedBox(height: 15,),
               new Expanded(child: _showPage) ,
               SizedBox(height: 15,),

              ],
            ),
            
          
        
    );
  }
}


// filter to order by departments 
// Show only Traited 
// Show Only non traited 
// Show only still 
// Show Replyed on 
