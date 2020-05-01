import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfe_mobile_app/models/mail_model.dart';
import 'package:sfe_mobile_app/screens/home/admin/AddDepartment.dart';
import 'package:sfe_mobile_app/screens/home/admin/Tiles/DepartTile.dart';



class ListAllService extends StatefulWidget {
 //final List<Departs> departs ;
  ListAllService();
 
  @override
  _ListAllServiceState createState() => _ListAllServiceState();
}

class _ListAllServiceState extends State<ListAllService> {
   GlobalKey _bottomNavigationKey = GlobalKey();


 void _addDep()
   {
      showModalBottomSheet(context: context, builder: (context)
      {
        return Scaffold(
          backgroundColor: Colors.black,
          body: SingleChildScrollView(child: AddDep()));
      });
   }
String _headerText = "Services";

  

  @override
  Widget build(BuildContext context) {
    
  final departs = Provider.of<List<Departs>>(context) ?? [];
setState(() {
  departs.removeWhere((item) => item.departsName == 'Tous');
  
});
   return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 50.0,
          items: <Widget>[
            Icon(Icons.add,size: 25,color: Colors.white, ),
          
            ],
          color: Colors.black,
          buttonBackgroundColor: Colors.black,
          backgroundColor: Colors.white,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
         
          
            setState(() {
            _addDep();
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
       itemCount: departs.length,
       itemBuilder: (context ,index)
       {
         return DepartTile(dep:departs[index]);
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
