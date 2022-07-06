import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class DireccionesScreen extends StatelessWidget {
   
  const DireccionesScreen({Key? key}) : super(key: key);
  
  @override
    Widget build(BuildContext context) {
    
    //print(scanListProvider.ListScans.length);
    return const ScanTiles(tipo: 'geo');
  }
}