

import 'dart:io';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:qr_reader/models/scan_model.dart';

//clase singlenton con un constructor 
class DBProvider{

  static Database? _database;

  static final DBProvider db = DBProvider._();//constructor

  DBProvider._();//contructir provado hacidno obenter como respultado la misma instacia de la bd

  Future<Database> get Getdatabase async {
    if(_database!=null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async{
    //Path de donde almacenar la base de datos
    Directory documentosDirectyory =  await getApplicationDocumentsDirectory();
    //path raro dentro de la 


    final path = join(documentosDirectyory.path, 'ScansDB.db');//ojo con la extencion db
    print(path);
    //crear base de datos

    return await openDatabase(
      path,
      version: 1,//version de la base de datos --- cojo cambiuar la version
      onOpen: (db){},
      onCreate: (Database db, int version) async {

        await db.execute('''
          CREATE TABLE Scans (
            id INTEGER PRIMARY KEY,
            tipo TEXT,
            valor TEXT
          )
        ''');
      }
      );

      
  }
  //insertar info en el qrry
  newScanRaw(ScanModel newScan) async{
    final id = newScan.id;
    final tipo = newScan.tipo;
    final valor = newScan.valor;

    final db = await Getdatabase;//espereamos q tener la base de datos
    final res = await db.rawInsert('''
      INSERT INTO Scans(id, tipo, valor)
        VALUES(${id},${tipo},${valor})
      '''
    );
    return res;
  }
  // agregar registros
  Future<int> newScanEasyForm (ScanModel newScan) async{
    final db = await Getdatabase;//espereamos q tener la base de datos
    final res = await db.insert('Scans', newScan.toJson());
    
    //id del ultimo registro insertado
    return res;
  }
  //obtener registros por id
  Future<ScanModel?> getScanById(int id) async{
    final db = await Getdatabase;//espereamos q tener la base de datos
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty 
    ? ScanModel.fromJson(res.first)
    :null;
  }
  //obtener todo los registors
  Future<List<ScanModel>?> getAllScans() async{
    final db = await Getdatabase;//espereamos q tener la base de datos
    final res = await db.query('Scans');
    return res.isNotEmpty 
    ? res.map(((e) => ScanModel.fromJson(e))).toList()
    :[];
  }
  // obtener registros segun el tipo
  Future<List<ScanModel>?> getScansType(String tipo) async{
    final db = await Getdatabase;//espereamos q tener la base de datos
    final res = await db.rawQuery('''
      SELECT * FROM Scans WHERE tipo = '$tipo'
    ''');
    return res.isNotEmpty 
    ? res.map(((e) => ScanModel.fromJson(e))).toList()
    :[];
  }
  //actualirzar registros
  Future<int> updateScan(ScanModel newScan) async{
    final db = await Getdatabase;//espereamos q tener la base de datos
    final res = await db.update('Scans', newScan.toJson(), where: 'id = ?', whereArgs: [newScan.id]);
    return res;
  }

  //boorrar datos
  Future<int> deleteScan(int id) async{
    final db = await Getdatabase;
      final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);
      return res;
  }

//boorrar datos
  Future<int> deleteAllScan() async{
    final db = await Getdatabase;
      //final res = await db.delete('Scans');
      final res = await db.rawDelete('''DELETE FROM Scans''');
      return res;
  }

}
