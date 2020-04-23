import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:griteria/models/song.dart';
import 'package:griteria/utils/customslider.dart';
import 'package:griteria/utils/musicplayer.dart';
import 'package:griteria/variables/appcolors.dart';
import 'dart:io' as io;

class SelectedSongScreen extends StatefulWidget {

  final Song songSelected;

  SelectedSongScreen({Key key, @required this.songSelected }) : super(key: key);

  @override
  _SelectedSongScreenState createState() => _SelectedSongScreenState( this.songSelected );
}

class _SelectedSongScreenState extends State<SelectedSongScreen>  with  WidgetsBindingObserver {

  final Song songSelected;

  MusicPlayer _musicPlayer;
  AudioCache _audioPlayerInstance;

  bool _alreadyLoadedFile;

  bool _isPlaying;

  int _durationAudioComplete = 0;
  int _durationPlaying = 0;

  _SelectedSongScreenState ( this.songSelected  );

  bool _hasMusic = false;

  @override
  void initState() {
    
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    initializeAudioPlayer();
  }

  initializeAudioPlayer() async {

    _isPlaying = false;
    _alreadyLoadedFile = false;
    _musicPlayer = new MusicPlayer();

    bool isThereAudio = await _musicPlayer.initialize(  songSelected.mp3 );
    
    
    _audioPlayerInstance = _musicPlayer.getInstance() ;

    if (isThereAudio)
      setState(() {
        _hasMusic = true;
      });

  

    setListeners();
  }

  setListeners() {
    
    _audioPlayerInstance.fixedPlayer.onPlayerStateChanged.listen((AudioPlayerState s) {
  
      if (s == AudioPlayerState.PLAYING ) {
        setState(() {
          _isPlaying = true;
        });
      }

      else if (s == AudioPlayerState.PAUSED ) {
        setState(() {
          _isPlaying = false;
        });
      }
      
    });

    _audioPlayerInstance.fixedPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        _isPlaying = false;
      });
    });

    _audioPlayerInstance.fixedPlayer.onAudioPositionChanged.listen((Duration  p)  {
      setState(() => _durationPlaying = p.inSeconds );
    });

    _audioPlayerInstance.fixedPlayer.onDurationChanged.listen((Duration d) {
      setState(() => _durationAudioComplete = d.inSeconds ) ;
    });

  }


  void playAudio() {

    if ( _isPlaying == true  ) {
      _audioPlayerInstance.fixedPlayer.pause();
    }
    else {

      if ( _alreadyLoadedFile == false ) {
        _audioPlayerInstance.play( "audios/" + songSelected.mp3 + ".mp3" );
      } else {
        _audioPlayerInstance.fixedPlayer.resume();
      }
    }
  }

   //When the user move the slider
  void handleChangeInSlider( double secondsSelected ) async  {

    Duration selectedSecond = Duration( seconds: secondsSelected.toInt() );
    await _audioPlayerInstance.fixedPlayer.seek( selectedSecond );
  }


  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _musicPlayer.release();
    super.dispose();
  }

  
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _audioPlayerInstance.fixedPlayer.pause();
    }
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: <Widget>[

            Stack(
              children: <Widget>[

                Container(
                  padding: EdgeInsets.only(top: 15),
                  height: (MediaQuery.of(context).size.height * 0.35 ).round().toDouble() ,
                  color: AppColors.primary,
                  child: Column(
                    children: <Widget>[
                      Row(   
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget> [ 
                          //Back button
                          IconButton(
                            padding: EdgeInsets.all(30),
                            icon: Icon(Icons.arrow_back),
                            color: AppColors.maincontent,
                            onPressed: () { Navigator.pop(context); },
                          ),
                          //Music icon
                          IconButton(
                            padding: EdgeInsets.all(30),
                            icon: Icon(Icons.music_note),
                            color: AppColors.maincontent,
                            //tooltip: 'Increase volume by 10',
                            onPressed: () {},
                          ),
                        ]
                      ),
                      Row(
                        children: <Widget> [
                          Container(
                            padding: EdgeInsets.only(left: 20),
                            margin: EdgeInsets.only(left: 15),
                            width: MediaQuery.of(context).size.width * 0.30 ,
                            decoration: BoxDecoration(
                              borderRadius: new BorderRadius.all ( const Radius.circular(25.0) ),
                            ),
                            child: Hero(
                              tag: 'mariaHeroWidget-' + songSelected.id.toString() ,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Image(
                                  image:  AssetImage('assets/maria.jpg' ),
                                ),
                              ), 
                            )    
                          ),         
                          Container(
                            height: 100,
                            child: Column(
                              children: <Widget> [
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      this.songSelected.name,
                                      style: TextStyle(
                                        color: AppColors.maincontent,
                                        fontSize: 15
                                      ),                             
                                    ),                                                         
                                  ) 
                                ),
                                Visibility(
                                  visible: _hasMusic,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.60 ,
                                    height: 60,
                                    child: Padding( 
                                      padding: EdgeInsets.all(10),
                                      child: CustomSlider( 
                                        onChangeBar: handleChangeInSlider , 
                                        durationCompleted: _durationAudioComplete ,
                                        durationPlaying: _durationPlaying, 
                                        
                                      )
                                    )
                                  ),
                                )
                              ]

                            ),
                          ),                                                            
                        ]                  
                      )
                    ],
                  ),
                ),
                //Stack for design curved
                Stack(
                  
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: (MediaQuery.of(context).size.height * 0.35 ).round().toDouble() ),
                      //height: (MediaQuery.of(context).size.height * 0.35 ).round().toDouble() ,
                      height:  MediaQuery.of(context).size.height - (MediaQuery.of(context).size.height * 0.35 ).round().toDouble() ,
                      color: AppColors.primary,
                    ),

                    Container(
                      margin: EdgeInsets.only(top: (MediaQuery.of(context).size.height * 0.35 ).round().toDouble() ),
                      height: MediaQuery.of(context).size.height - (MediaQuery.of(context).size.height * 0.35 ).round().toDouble() ,
                      //padding: EdgeInsets.only(top: 30),
                      //color: AppColors.primary,
                      decoration: BoxDecoration(
                        color: AppColors.maincontent,
                        borderRadius: BorderRadius.only( topLeft : Radius.circular (45.0) , topRight: Radius.circular (45.0) )
                      ), 
                      child: NotificationListener<OverscrollIndicatorNotification>(
                        onNotification: (overscroll) {
                          overscroll.disallowGlow();
                          return null;
                        },
                        child: Scrollbar(
                          child: new ListView(
                            children: <Widget>[
                              Text( ( "\n\n\n" + songSelected.lyrics  + "\n\n" ),
                              textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ) ,
                      ),                         
                    ),
                    
                  ]
                ), 
                     
                Visibility(
                  visible: _hasMusic,
                  child: Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(top: (MediaQuery.of(context).size.height * 0.31 ).round().toDouble() , right: 20) ,
                    child: RawMaterialButton(
                    onPressed: () {
                      playAudio();
                    },
                    child: new Icon(
                      _isPlaying ? Icons.pause : Icons.play_arrow ,
                      color: Colors.white,
                      size: 40.0,
                    ),
                    shape: new CircleBorder(),
                    elevation: 1,
                    fillColor: AppColors.colorPlayButton,
                    padding: EdgeInsets.all(10),
                    //padding: EdgeInsets.only(top: (MediaQuery.of(context).size.height * 0.35 ).round().toDouble() ) ,
                    ),
                  ),
                )
              ],
            ),               
          ],           
        ),
      )    
    );
  }
}