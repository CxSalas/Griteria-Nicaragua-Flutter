import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:griteria/screens/listscreen.dart';
import 'package:griteria/variables/appcolors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors.primary ,
        statusBarBrightness: Brightness.light,
      )
    );
  

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Griteria Nicaragua',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  ListScreen()
    );
  }
}

