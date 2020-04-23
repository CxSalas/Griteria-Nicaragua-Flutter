import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class MusicPlayer {

  AudioPlayer _advancedPlayer;
  AudioCache _audioCache;


  Future<bool> initialize( String path  ) async {
    _advancedPlayer = AudioPlayer();
    _audioCache = AudioCache( fixedPlayer: _advancedPlayer );
    
    //await _audioCache. audioPlayer.setReleaseMode(ReleaseMode.STOP);

    //Return true if exists a file 
    try {
      await _audioCache.load( "audios/" + path + ".mp3" );
    } catch (e)  {
      return false;

    }
   
    return true;
  }

  Future loadMusic( path ) async {
    //_audioCache.fixedPlayed. ("audios/" +path + ".mp3" );
    _audioCache.fixedPlayer.play("audios/" + path + ".mp3" );
  }

  /*Future pauseMusic () async {
    advancedPlayer
  }*/

  void pauseMusic() {
    _audioCache.fixedPlayer?.pause();
  }

  AudioCache getInstance() {
    return _audioCache;
  }

  
  Future release () async {
    await _audioCache.fixedPlayer?.release();
  }

}