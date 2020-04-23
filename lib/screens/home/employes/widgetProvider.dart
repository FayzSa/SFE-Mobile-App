import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfe_mobile_app/models/user_model.dart';
import 'package:sfe_mobile_app/screens/home/employes/mainEmployes.dart';
import 'package:sfe_mobile_app/screens/home/employes/nonTraited.dart';
import 'package:sfe_mobile_app/screens/home/employes/traitedMails.dart';
import 'package:sfe_mobile_app/services/authService.dart';
import 'package:sfe_mobile_app/shared/loading.dart';


class WidgetProvider extends StatefulWidget {
  @override
  _WidgetProviderState createState() => _WidgetProviderState();
}

class _WidgetProviderState extends State<WidgetProvider> {


String _headerText = "All Mails";


   GlobalKey _bottomNavigationKey = GlobalKey();
    Widget _showPage = MainEmployes();

  Widget _choosenPage(int index){
    
     if(index == 0) return MainEmployes();
     if(index == 1) return TraitedMails();
     if(index == 2) return NonTraited();
     //if(index == 3) return _aboutDev;
     else {
       return 
         Container(
           padding: EdgeInsets.all(50),
           child:Center(child: Text("There's No Selected Page !!"))
         );
     }
   }

  @override
  Widget build(BuildContext context) {
  final userdata = Provider.of<UserData>(context); 
   return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 50.0,
          items: <Widget>[
            Icon(Icons.mail, size: 25,color: Colors.white),
            Icon(Icons.drafts, size: 25,color: Colors.white),
            Icon(Icons.cancel, size: 25,color: Colors.white),
           
            Icon(Icons.exit_to_app, size: 25,color: Colors.white),
            ],
          color: Colors.black87,
          buttonBackgroundColor: Colors.black87,
          backgroundColor: Colors.white,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index){
            if(index == 3){
              setState(() async{
              _showPage =  Loading();
              await AuthService().signOut();
                
              });
            }
            setState(() {
              if(index == 0) _headerText = "All Mails";
              if(index == 1) _headerText = "Traited Mails";
              if(index == 2) _headerText = "Non Traited Mails";
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
                    color: Colors.black87,
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
                            Text("Department  ${userdata.departement}" ,style: TextStyle(
                              color: Colors.white,
                              
                              fontSize: 12
                            ),
                            )
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