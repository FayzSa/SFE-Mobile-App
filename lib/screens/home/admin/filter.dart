import "package:flutter/material.dart";
import 'package:sfe_mobile_app/screens/home/admin/listAllMails.dart';
import 'package:sfe_mobile_app/screens/home/admin/listNonTraitedAdmin.dart';
import 'package:sfe_mobile_app/screens/home/admin/listStill.dart';
import 'package:sfe_mobile_app/screens/home/admin/listTraite.dart';

class Filters extends StatefulWidget {
  @override
  _FiltersState createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  Widget listMails = ListAllMails();
  @override
  Widget build(BuildContext context) {
    return Column
    (
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                FlatButton(
                color: Colors.grey[200],
                
                  shape:  RoundedRectangleBorder(
  borderRadius: new BorderRadius.only(topLeft: Radius.circular(18),bottomLeft: Radius.circular(18)),
),
                onPressed: (){
                  setState(() {
                  listMails = StillAdmin();
                  });
                }, child:       CircleAvatar(
            radius: 4.0,
            backgroundColor: Colors.green[200],
              ),),
              Text("En Cours",style: TextStyle(color: Colors.green[200]),),
              ],
              
            ),
            Column(

              children: <Widget>[
                FlatButton(onPressed: (){
                  setState(() {
                    listMails = TraitedAdmin();
                  });
                }, child:       CircleAvatar(
            radius: 4.0,
            backgroundColor: Colors.green[400],
              ),
              color: Colors.grey[200],
              ),
              Text("Traite",style: TextStyle(color: Colors.green[400]),),
              ],
            ),
            Column(
              children: <Widget>[
                FlatButton(
                  color: Colors.grey[200],
                  shape:  RoundedRectangleBorder(
  borderRadius: 
  new BorderRadius.only(topRight: Radius.circular(18),bottomRight: Radius.circular(18)))
                  ,onPressed: (){
                    setState(() {
                      listMails = NonTraitedAdmin();
                    });
                }, child:       CircleAvatar(
            radius: 4.0,
            backgroundColor: Colors.red[500],
              ),),
              Text("Non Traite",style: TextStyle(color: Colors.red[500]),),
              ],
            ),
          ],
        ),
        
            new Expanded(child: listMails),
      ],
    );
  }
}