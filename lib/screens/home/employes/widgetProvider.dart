import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfe_mobile_app/models/user_model.dart';
import 'package:sfe_mobile_app/screens/Auth/authenticate.dart';
import 'package:sfe_mobile_app/screens/home/employes/mainEmployes.dart';
import 'package:sfe_mobile_app/screens/home/employes/nonTraited.dart';
import 'package:sfe_mobile_app/screens/home/employes/traitedMails.dart';
import 'package:sfe_mobile_app/services/authService.dart';
import 'package:sfe_mobile_app/services/notificationservice.dart';
import 'package:sfe_mobile_app/shared/loading.dart';


class WidgetProvider extends StatefulWidget {
  @override
  _WidgetProviderState createState() => _WidgetProviderState();
}

class _WidgetProviderState extends State<WidgetProvider> {

 GestionNotification gn = new GestionNotification();
  @override
 initState(){
   super.initState();
   ///with these tow lines we add the employer to a topic for receiving messages 
   String departement = Provider.of<UserData>(context,listen: false).departement;
  gn.addtotopic(departement);
 }

String _headerText = "Tous les courriers";


   GlobalKey _bottomNavigationKey = GlobalKey();
    Widget _showPage = MainEmployes();

  Widget _choosenPage(int index){
    
     if(index == 0) return MainEmployes();
     if(index == 1) return TraitedMails();
     if(index == 2) return NonTraited();
     if(index == 3) return MainEmployes();
     else {
       return 
         Container(
           padding: EdgeInsets.all(50),
           child:Center(child: Text("Il n'y a pas de page sélectionnée !!"))
         );
     }
   }

  @override
  Widget build(BuildContext context) {
  final userdata = Provider.of<UserData>(context); 
   return userdata == null ? Auth(): Scaffold(
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
          color: Colors.black,
          buttonBackgroundColor: Colors.black,
          backgroundColor: Colors.white,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index)async{
            if(index == 3){
             
         
              showModalBottomSheet(context: context, builder: (context)
                              {
                                return Container(
                                       height: MediaQuery.of(context).size.height/8,                       
                          color: Colors.black,
                          child: Column(
                            
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,

                           children: <Widget>[
                            Center(
                             child:Text("Êtes-vous sûr ?",style:TextStyle(
                              color: Colors.white,
                               fontSize: 25,
                                  )),
                                   ),
                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: <Widget>[
                                       FlatButton(onPressed: ()async{  
                                                      setState(() {
                                                        _showPage=Loading();
                                                      });
                                                      
                                                        await AuthService().signOut();
                                                      
               
                                         Navigator.pop(context);
                                       }, 
                             child:
                             Text("Oui", style:TextStyle(
                             color: Colors.white
                              )
                              )
                              ),
                                     FlatButton(onPressed: (){
                                         Navigator.pop(context);
                                       }, 
                             child:
                             Text("Non", style:TextStyle(
                             color: Colors.white
                              )
                              )
                              ),
                                   ],
                                   
                                   )
                               ],
                                  )
                               );
                                
                              });
                           
    
              
            }
            setState(() {
              if(index == 0) _headerText = "Tous les courriers";
              if(index == 1) _headerText = "Mails traités";
              if(index == 2) _headerText = "Courriers non traités";
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
                            Text("Service  ${userdata.departement}" ,style: TextStyle(
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