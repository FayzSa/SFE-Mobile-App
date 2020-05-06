import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfe_mobile_app/models/mail_model.dart';
import 'package:sfe_mobile_app/models/user_model.dart';
import 'package:sfe_mobile_app/screens/home/admin/addEmp.dart';

import 'Tiles/EmpTile.dart';


class ListAllEmp extends StatefulWidget {
  final List<Departs> departs;
 ListAllEmp({this.departs});
  @override
  _ListAllEmpState createState() => _ListAllEmpState();
}

class _ListAllEmpState extends State<ListAllEmp> {
   GlobalKey _bottomNavigationKey = GlobalKey();

       void _addEmp()
   {

            Navigator.push(context, MaterialPageRoute<Null>(
          builder: (BuildContext context) {
   return Scaffold(
          backgroundColor: Colors.black,
          body: SingleChildScrollView(child:AddEmp(deparemtens:widget.departs)));
          },
          fullscreenDialog: true,
        ));


    
   }
String _headerText = "Personel";

  

  @override
  Widget build(BuildContext context) {
    final users =Provider.of<List<UserData>>(context) ?? []; 

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
            _addEmp();
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
       itemCount: users.length,
       itemBuilder: (context ,index)
       {
         return EmpTile(emp: users[index] , deprats :widget.departs);
       }
       
       
       
     ),
               ) ,
               SizedBox(height: 15,),

              ],
            ),
            
          
        
    );
  }
}

