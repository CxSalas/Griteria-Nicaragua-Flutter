import 'package:flutter/material.dart';

class ScreenSizes {
  
  static Size displaySize(BuildContext context) {
    //debugPrint('Size = ' + MediaQuery.of(context).size.toString());
    return MediaQuery.of(context).size;
  }

  static double displayHeight(BuildContext context) {
    //debugPrint(kToolbarHeight.toString() );
    return displaySize(context).height ;
  }
}