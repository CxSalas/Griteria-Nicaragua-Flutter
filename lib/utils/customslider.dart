import 'package:flutter/material.dart';

class CustomSlider extends StatelessWidget {

  final int durationCompleted ;
  final int durationPlaying ;

  final void Function( double value ) onChangeBar;

  const CustomSlider({Key key, @required this.durationCompleted, @required this.durationPlaying, @required this.onChangeBar  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        valueIndicatorColor: Colors.white, // This is what you are asking for
        inactiveTrackColor: Color(0xFF8D8E98), // Custom Gray Color
        activeTrackColor: Colors.white,
        thumbColor: Colors.red,
        overlayColor: Color(0x29EB1555),  // Custom Thumb overlay Color
        thumbShape:
            RoundSliderThumbShape(enabledThumbRadius: 6.0),
        overlayShape:
            RoundSliderOverlayShape(overlayRadius: 2.0)),
      
      child: Slider(
        value: durationPlaying.toDouble(),
        onChanged: (value) async {
          onChangeBar( value );
        },
        min: 0,
        max: durationCompleted.toDouble() ,
        activeColor: Colors.white,
        //inactiveColor: Colors.deepOrange,
      ),
    );
  }
}