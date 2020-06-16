import 'package:flutter/material.dart';
import 'package:sfe_mobile_app/models/user_model.dart';
import 'package:sfe_mobile_app/screens/home/admin/Show/ShowEmp.dart';
import 'package:sfe_mobile_app/services/databaseService.dart';



class EmpTile extends StatelessWidget {
  final UserData emp;
  final deprats ;
  EmpTile({this.emp , this.deprats});
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                        
                                        Row(
                                          children: <Widget>[
                                              Icon(Icons.person_outline, size: 18,),
                                                SizedBox(width: 10),
                                            Text(emp.fullName ?? "NON",style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15,
                                      ),
                                      ),


                                                SizedBox(width: 10),
                                            Text(emp.departement ?? "NON",style: TextStyle(
                                            color: Colors.black,
                                           
                                            fontSize: 13,
                                      ),
                                      ),

                                          ],
                                        ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              IconButton(icon: Icon(Icons.edit, size: 15,), onPressed: (){

                                  showModalBottomSheet(context: context, builder: (context)
                                  {
                                    return Scaffold(
                                      backgroundColor: Colors.black,
                                      body: SingleChildScrollView(child: ShowEmp(userData: emp,
                                      deparemtens: deprats,)
                                      
                                      )
                                      );
                                  });

                                }),
                            IconButton(icon: Icon(Icons.delete, size: 15,), onPressed: (){
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
                                         await DatabaseService().disable(emp.uid);
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
                                                
                           // 
                          }
                          )
                            ],
                          ),
                                      ],
                                      ),
        
        
        ],
      ),
    );
  }
}