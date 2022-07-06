// To parse this JSON data, do
//
//     final scanModel = scanModelFromJson(jsonString);

import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
ScanModel scanModelFromJson(String str) => ScanModel.fromJson(json.decode(str));

String scanModelToJson(ScanModel data) => json.encode(data.toJson());

class ScanModel {
    int? id;
    String? tipo;
    String valor;

    ScanModel({
        this.id,
        this.tipo,
        required this.valor,
    }){
      if(valor.contains('http')){
        tipo = 'http';
      }else{
        tipo = 'geo';
      }
    }
    //obtener geolocation
    LatLng getGeoLocation(){
      final latLng;
      if(valor.contains('geo')){
        latLng = valor.substring(4).split(','); 
      }else{
         latLng = valor.split(',');
      }
       
      final lat  = double.parse(latLng[0]);
      final long  = double.parse(latLng[1]);
      return LatLng(lat, long);
    }


    factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        tipo: json["tipo"],
        valor: json["valor"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "valor": valor,
    };
}
