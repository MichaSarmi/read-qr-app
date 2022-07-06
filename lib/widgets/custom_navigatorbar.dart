import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/ui_provider.dart';


class CustomNavigatorbar extends StatelessWidget {
  const CustomNavigatorbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider =  Provider.of<UiProvider>(context);
    return BottomNavigationBar(
      onTap: (int i) => uiProvider.setSelectedMenuOpt=i,
      elevation: 0,
      currentIndex: uiProvider.selectedMenuOpt,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Mapa'
        ),
         BottomNavigationBarItem(
          icon: Icon(Icons.compass_calibration),
          label: 'Direcciones'
        )

      ],
    );
  }
}