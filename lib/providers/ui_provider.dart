
import 'package:flutter/material.dart';
//se exteinde del notfy para notificar a los widsgets de este cambi
class UiProvider extends ChangeNotifier{

  int _selectedMenuOpt = 0;

  int get selectedMenuOpt{
    return _selectedMenuOpt;
  } 
  //cambiar y mandar el escuchador
  set setSelectedMenuOpt(int i){
    _selectedMenuOpt = i;
    notifyListeners();
  }

}