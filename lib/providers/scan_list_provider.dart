import 'package:flutter/cupertino.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:qr_reader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier{

  List<ScanModel> ListScans = [];
  String typeSelect = 'http';

  Future<ScanModel> newScan(String valor) async{
    final newScan = ScanModel(valor: valor);
    final id = await DBProvider.db.newScanEasyForm(newScan);
    //asigarn el id d ela base de datos al modelo
    newScan.id = id;
    //se debe acuizar la interfaz si es scan
    if(typeSelect == newScan.tipo){
      ListScans.add(newScan);
      notifyListeners();
    }
    return newScan;

  }

  chargeScans() async{
    final scans = await DBProvider.db.getAllScans();
    ListScans = [...?scans];
    notifyListeners();

  }

  chargeScanType(String tipo) async {
    final scans = await DBProvider.db.getScansType(tipo);
    ListScans = [...?scans];
    typeSelect = tipo;
    notifyListeners();

  }

  deleteAllScans() async{
    await DBProvider.db.deleteAllScan();
    notifyListeners();
  }

  deleteScanByID(int id) async{
     await DBProvider.db.deleteScan(id);
     chargeScanType(typeSelect);//cargar todos--- mejor buscar el elemento a elminnar y sacar;p del array
     notifyListeners();
  }

}
