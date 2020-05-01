import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfe_mobile_app/models/user_model.dart';
import 'package:sfe_mobile_app/screens/home/admin/Tiles/AdminTile.dart';
import 'package:sfe_mobile_app/screens/home/admin/addAdmin.dart';


class ListAllAdmins extends StatefulWidget {
 
  @override
  _ListAllAdminsState createState() => _ListAllAdminsState();
}

class _ListAllAdminsState extends State<ListAllAdmins> {
   GlobalKey _bottomNavigationKey = GlobalKey();


 void _addAdmin()
   {
      showModalBottomSheet(context: context, builder: (context)
      {
        return Scaffold(
          backgroundColor: Colors.black,
          body: SingleChildScrollView(child: AddAdmin()));
      });
   }
String _headerText = "Admins";

  

  @override
  Widget build(BuildContext context) {

  final  admins = Provider.of<List<UserData>>(context) ?? []; 
   return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 50.0,
          items: <Widget>[
            Icon(Icons.person_add,size: 25,color: Colors.white, ),
          
            ],
          color: Colors.black,
          buttonBackgroundColor: Colors.black,
          backgroundColor: Colors.white,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
         
          
            setState(() {
            _addAdmin();
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
               new Expanded(child:
               ListView.builder(
       itemCount: admins.length,
       itemBuilder: (context ,index)
       {
         return AdminTile(admin: admins[index]);
       }
       
       
       
     ),
               ) ,
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
