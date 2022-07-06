import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/utils/utils.dart';

import '../providers/providers.dart';

class ScanTiles extends StatelessWidget {
   final String tipo;
   
  const ScanTiles({
    Key? key,
    required this.tipo
    }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final scanListProvider =  Provider.of<ScanListProvider>(context); 
    //print(scanListProvider.ListScans.length);
    return ListView.builder(
        itemCount: scanListProvider.ListScans.length,
        itemBuilder: (_, i) => Dismissible(

          key: UniqueKey(),
          background: Container(
            color: Colors.purple[50],
          ),
          onDismissed: (DismissDirection direction){
            //aqui se vuelve a declarar el Scan rivoder por qe necesita un listened false por q el widget se encarga de eleimarlo visualmente
            Provider.of<ScanListProvider>(context,listen: false).deleteScanByID(scanListProvider.ListScans[i].id!);
          },
          child: ListTile(
            leading: Icon(
              tipo == 'http'
              ?Icons.home_outlined
              :Icons.map_outlined,
              color: Theme.of(context).primaryColor,),
            title:   Text(scanListProvider.ListScans[i].valor),
            subtitle: Text(scanListProvider.ListScans[i].id.toString()),
            trailing: const Icon(Icons.keyboard_arrow_right_rounded, color: Colors.grey,),
            onTap: (){
              //abrir pagina web desde a app
              LaunchUrl(context, scanListProvider.ListScans[i]);
            },
          ),
        )
      );
  }
}