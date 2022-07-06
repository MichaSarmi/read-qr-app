import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/db_provider.dart';
import 'package:qr_reader/providers/providers.dart';
import 'package:qr_reader/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context,listen: false);
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: (){
              scanListProvider.deleteAllScans();
            }, 
            icon: const Icon(Icons.delete_forever))
        ],
      ),
      body: _HomePageBody(),
      bottomNavigationBar: const CustomNavigatorbar(),
      floatingActionButton: const ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    //obteber el provider del menu
    final uiProvider =  Provider.of<UiProvider>(context);
    //todo EL LER BASE DE DATOS
    DBProvider.db.Getdatabase;
    //final tempScan = ScanModel(valor: 'http://gogle.com');
    //final initTemp= DBProvider.db.newScanEasyForm(tempScan);
    //DBProvider.db.getAllScans().then((value) => print(value));
    //print( initTemp);
    //cambiar pagina \
    final curretIndex=uiProvider.selectedMenuOpt;
    //scan list potvider
    final scanListProvider =  Provider.of<ScanListProvider>(context,listen: false);
    switch(curretIndex){
      case 0:
      scanListProvider.chargeScanType('geo');
      return const ScanTiles(tipo: 'geo');

      case 1:
       scanListProvider.chargeScanType('http');
      return const ScanTiles(tipo: 'http');

      default:
      return const ScanTiles(tipo: 'geo');
    }
  }
}