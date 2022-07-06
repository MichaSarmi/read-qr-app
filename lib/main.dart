import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/providers.dart';
import 'package:qr_reader/screens/screens.dart';
import 'package:qr_reader/themes/app_theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //buscar 
        ChangeNotifierProvider(create: (_)=>  UiProvider()),
        ChangeNotifierProvider(create: (_)=>  ScanListProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Qr Reader',
        initialRoute:'home/' ,
        routes: {
          'home/': (_)=> const HomeScreen(),
          'map/': (_)=> const MapaScreen()
        },
        theme: AppTheme.ligthTheme,
       
      ),
    );
  }
}