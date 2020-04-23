import 'package:flutter/material.dart';
import 'package:griteria/utils/screensizes.dart';
import 'package:griteria/variables/widgetsizes.dart';

class TestScafold extends StatelessWidget {
  const TestScafold({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container (
            color: Colors.blue,
            height: WidgetSizes.topWidgetHeight,
          ),
          Container(
            height: ScreenSizes.displayHeight(context) - WidgetSizes.topWidgetHeight ,
            color: Colors.red 
          ),

        ]
      )
    );
  }
}