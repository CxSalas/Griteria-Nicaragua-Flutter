import 'package:flutter/material.dart';
import 'package:griteria/models/song.dart';
import 'package:griteria/screens/selectedsongscreen.dart';
import 'package:griteria/variables/appcolors.dart';
//import 'package:griteria/variables/widgetsizes.dart';

class CardSong extends StatelessWidget {

  final Song songEspecific;

  const CardSong({Key key , @required this.songEspecific }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SelectedSongScreen( songSelected : this.songEspecific ) ),
          );
        },
        
        child: Container(
          height: 70,
          margin: EdgeInsets.only(right: 20, top: 10, left: 5 , bottom: 10 ) ,
          decoration: BoxDecoration(
            gradient: new LinearGradient(
                stops: [0.02, 0.02],
                colors: [AppColors.primary , Colors.white]
            ),
            color: Colors.white,

            borderRadius: new BorderRadius.only(
              bottomRight: const Radius.circular(25.0),
              topRight: const Radius.circular(25.0),
            ),
            
            boxShadow: <BoxShadow>[
              new BoxShadow(
                color: Color (0xFFBBBBBB),
                //blurRadius: 2.0,
                //spreadRadius: 0.4,
                offset: Offset(0.1, 0.1)
              ),
            ],
          ),

        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 5),
              child: Hero(
                tag: 'mariaHeroWidget-' + songEspecific.id.toString(),
                child: Image(
                  image:  AssetImage('assets/maria.jpg' ),
                ), 
              )
            ),
            
            Flexible(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(this.songEspecific.name ),
              
              ) 
            )
           
           
          ]
          
        ) 
      ),
    );
  }
}