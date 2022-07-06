import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';

import '../utils/utils.dart';
class ScanButton extends StatelessWidget {
  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      onPressed: () async {
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#3D8BEF', 'Cancelar', false, ScanMode.QR);
        //final barcodeScanRes = 'geo:-0.07538919427845212,-78.45979228253047';
        //final barcodeScanRes = 'https://www.bipgo.com';
        if(barcodeScanRes == '-1'){
          return;
        }
        print(barcodeScanRes);
        final scanListPRrovider = Provider.of<ScanListProvider>(context,listen: false);
       // scanListPRrovider.newScan(barcodeScanRes);
        //scanListPRrovider.newScan('geo:-0.07538919427845212,-78.45979228253047');
        final ScanModel newScan = await scanListPRrovider.newScan(barcodeScanRes);
        LaunchUrl(context, newScan);
      },
      child: const Icon(Icons.filter_center_focus),
      );
  }
}