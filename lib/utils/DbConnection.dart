import 'dart:io';

import 'package:flutter/services.dart';
import 'package:griteria/models/song.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';

class DbConnection {

  Database _myDb ; 

  //Try to open a existing database, if it not exist, then create a new one from a file in assets folder.
  tryOpenDatabase() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, 'Griteria.db');

    var databaseExists = await databaseFactory.databaseExists(dbPath);

    if ( databaseExists == true ) 
      _myDb = await openDatabase(dbPath, version: 1 );
    else 
      _myDb = await copyDatabase();
  }

  //Copy the local database from assets folder, to the path of the aplication
  Future<Database> copyDatabase() async {

    // Construct the path to the app's writable database file:
    var dbDir = await getDatabasesPath();
    var dbPath = join(dbDir, "Griteria.db");

    // Delete any existing database:
    await deleteDatabase(dbPath);

    // Create the writable database file from the bundled demo database file:
    ByteData data = await rootBundle.load("assets/Griteria.db");
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(dbPath).writeAsBytes(bytes);

    return await openDatabase(dbPath, version: 1 );
  }
  


  Future<List<Song>> getSongs() async {
    
    final List<Map<String, dynamic>> maps = await _myDb.rawQuery('SELECT * FROM Songs');
    //return result.toList();

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Song(
        id: maps[i]['Id'],
        name: maps[i]['Name'],
        lyrics: maps[i]['Lyric'],
        mp3 : maps[i]['MP3']
      );
    });
  }

}