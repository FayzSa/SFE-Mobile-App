import 'package:flutter/material.dart';


 dynamic textInputDeco = InputDecoration(
                 
                 fillColor: Colors.white,
                 filled: true,
                 enabledBorder: OutlineInputBorder(
                   borderSide: BorderSide(color:Colors.grey[400],width: 2.0),
                   borderRadius: BorderRadius.circular(20),
                 ),
                 focusedBorder: OutlineInputBorder(
                   borderSide: BorderSide(color:Colors.white30,width: 2.0),
                   borderRadius: BorderRadius.circular(20)
                 ),
               );