import 'package:flutter/material.dart';
import 'package:griteria/components/cardsong.dart';
import 'package:griteria/components/thetitleapp.dart';
import 'package:griteria/models/song.dart';
import 'package:griteria/utils/DbConnection.dart';
import 'package:griteria/utils/screensizes.dart';
import 'package:griteria/variables/appcolors.dart';
import 'package:griteria/variables/projecttext.dart';
import 'package:griteria/variables/widgetsizes.dart';

class ListScreen extends StatefulWidget {
  ListScreen({Key key}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}


class _ListScreenState extends State<ListScreen> {

  List<Song> _songsList = new List<Song>();
  List<Song> _filterList = new List<Song>();

  double heightScreen ;

  void initState(){
    super.initState();

    loadData();
  }

  //Load song list from database
  loadData()  async {

    DbConnection dbConnection = new DbConnection();
    await dbConnection.tryOpenDatabase();

    var theSongsList = await dbConnection.getSongs();

    setState(() {
      _songsList = theSongsList;
      _filterList = theSongsList;
    });

  

    //print(_songsList.length );

  }

  //Filter by search input
  void searchInput(String text) async {
    
    //print(text);
    List<Song> filteredList = _songsList.where( (item) => item.name.toLowerCase() .contains( text.toLowerCase() ) ).toList() ; 

    //print(filteredList.length );
    setState(() {
      _filterList = filteredList;
    });
  

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.maincontent,
      body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
          //physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[
            Container(
              height: WidgetSizes.topWidgetHeight,   
              decoration: BoxDecoration(
                color: AppColors.primary
              ), 
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children : <Widget> [
                  TheTitleApp(),

                  new Container(
                    margin: EdgeInsets.all(30),
                    padding: EdgeInsets.only(left: 10, right : 10),
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: new BorderRadius.all( Radius.circular(40.0) )
                    ),
                    child: new TextField(
                      onChanged: (String text) async {
                        this.searchInput(text);
                      },
                      textAlign: TextAlign.left,
                      decoration: new InputDecoration(
                        hintText: ProjectText.searchHint,
                        
                        border: InputBorder.none,
                        fillColor: Colors.white,
                        hintStyle: new TextStyle(
                          
                          color: Color(0xFFD6D3CB)
                        )
                      ),
                    ),
                  )
                ]
              ) ,
            ),

            /* Main Container */
            Stack(
              children: <Widget> [
                //Container for the curved design 
                Container(
                  height: (   ScreenSizes.displayHeight(context) - WidgetSizes.topWidgetHeight  ),    
                  decoration: BoxDecoration(
                    color: AppColors.primary
                  ), 
                ),
                //Main container that holds the content
                Container(
                  height: ( ScreenSizes.displayHeight(context) - WidgetSizes.topWidgetHeight  ),    
                  decoration: BoxDecoration(
                    color: AppColors.maincontent ,
                    borderRadius: BorderRadius.only( topLeft : Radius.circular (45.0) , topRight: Radius.circular (45.0) )
                  ), 
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: ( MediaQuery.of(context).size.width * 0.15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new RotatedBox(
                              quarterTurns: 3,
                              child: Text(
                                ProjectText.lateralOptionOne,
                                style: TextStyle(
                                  color: AppColors.primary
                                ),
                              ),
                            ),
                          ]
                        ),
                      ),
                      Container(
                        //height: MediaQuery.of(context).size.height  ,    
                        margin: EdgeInsets.only(top: 10),
                        width: ( MediaQuery.of (context).size.width * 0.85 ),
                        child: NotificationListener<OverscrollIndicatorNotification>(
                          onNotification: (overscroll) {
                            overscroll.disallowGlow();
                            return null;
                          },
                          child: Scrollbar(
                            child: new ListView.builder
                            (
                              itemCount: _filterList.length,
                              itemBuilder: (BuildContext ctxt, int index) {
                                return new CardSong( songEspecific : _filterList[index]  );
                              }
                            )
                          ) ,
                        ),
                      )
                    ],
                  ) ,
                )
              ]
            )      
          ]
        ),
      ) ,
    );
  }
}