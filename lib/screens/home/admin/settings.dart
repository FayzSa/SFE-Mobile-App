import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:sfe_mobile_app/models/mail_model.dart';
import 'package:sfe_mobile_app/models/user_model.dart';
import 'package:sfe_mobile_app/screens/home/admin/listAdmins.dart';
import 'package:sfe_mobile_app/screens/home/admin/listDep.dart';
import 'package:sfe_mobile_app/screens/home/admin/listEmp.dart';
import 'package:sfe_mobile_app/services/databaseService.dart';

class Settings extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

  final services = Provider.of<List<Departs>>(context) ?? [];
  
  final UserData userAdmin = Provider.of<UserData>(context) ?? [];
  //
       void _addAdmin()
   {

            Navigator.push(context, MaterialPageRoute<Null>(
          builder: (BuildContext context) {
          return   StreamProvider<List<UserData>>.value(
      value: DatabaseService().admins,
                      child: 
             
             ListAllAdmins(uid:userAdmin.uid) ,
          );
          },
          fullscreenDialog: true,
        ));


    
   }

      void _addService()
   {

            Navigator.push(context, MaterialPageRoute<Null>(
          builder: (BuildContext context) {
          return   StreamProvider<List<Departs>>.value(
      value: DatabaseService().departments,
      child: ListAllService());
          },
          fullscreenDialog: true,
        ));


    
   }


    void _addEmp()
   {

            Navigator.push(context, MaterialPageRoute<Null>(
          builder: (BuildContext context) {
          return   StreamProvider<List<UserData>>.value(
      value: DatabaseService().users,
                      child: 
             
             ListAllEmp(departs: services) ,
          );
          },
          fullscreenDialog: true,
        ));


    
   }


 


    return SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
                          children: <Widget>[
                            SizedBox(height: 10),

                             Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                
                                Row(
                                  children: <Widget>[
                                      Icon(Icons.person , size:18),
                                        SizedBox(width: 10),
                                    Text("Admins" ,style: TextStyle(
                                    color: Colors.black,
                                     fontWeight: FontWeight.w700,
                                       
                                    fontSize: 15,
                              ),
                              ),
                                  ],
                                ),
                      IconButton(icon: Icon(Icons.arrow_forward_ios , size: 15,), onPressed: (){

                        _addAdmin();
                      })
                              ],
                              ),
                          
                            SizedBox(height: 10),


                                // Started 
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                    
                                    Row(
                                      children: <Widget>[
                                          Icon(Icons.person_outline, size: 18,),
                                            SizedBox(width: 10),
                                        Text("Personel" ,style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                  ),
                                  ),
                                      ],
                                    ),
                      IconButton(icon: Icon(Icons.arrow_forward_ios, size: 15,), onPressed: (){
                        _addEmp();
                      })
                                  ],
                                  ),
                              

                            SizedBox(height: 10),
                              // Started 
                            Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                    
                                    Row(
                                      children: <Widget>[
                                          Icon(Icons.business, size: 18,),
                                            SizedBox(width: 10),
                                        Text("Services" ,style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                  ),
                                  ),
                                      ],
                                    ),
                      IconButton(icon: Icon(Icons.arrow_forward_ios, size: 15,), onPressed: (){
                        _addService();
                      })
                                  ],
                                  ),
                              
                                // End
                          
                            SizedBox(height: 10),
                       

                                
                           

                       

                                
                            ]
                            ),
      ),
    );
  }
}