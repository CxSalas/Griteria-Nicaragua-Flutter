import 'package:flutter/material.dart';
import 'package:griteria/variables/projecttext.dart';

class TheTitleApp extends StatelessWidget {
  const TheTitleApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 40, top: 40) , 
      child:  Text(
    
        ProjectText.titleApp, 
        textAlign: TextAlign.left,
        
        style: new TextStyle(
          fontSize: 25,
          color: Colors.white,
        ),
      )  
    );
  }
}