import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class MapaScreen extends StatefulWidget {
   
  const MapaScreen({Key? key}) : super(key: key);

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
    final Completer<GoogleMapController> _controller = Completer();
    MapType mapType = MapType.normal;
  @override
   Widget build(BuildContext context) {
    final ScanModel  scan =  ModalRoute.of(context)!.settings.arguments as ScanModel; 
    
  
   //camare positoon mapa
    CameraPosition initialPosition  =  CameraPosition(
    target: scan.getGeoLocation(),
    tilt: 17.5,
    zoom: 17,);
    //markadores
    Set<Marker> markers =  Set<Marker>();
    markers.add(
      Marker(
        markerId: const MarkerId('central-marker'),
        position:  scan.getGeoLocation()
        )
    );
    //print(scanListProvider.ListScans.length);
    
    return  Scaffold(
      appBar: AppBar(
        title: const Text('mapa'),
        actions: [
          IconButton(
             icon: const Icon(Icons.location_on),
             onPressed: () async{
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: scan.getGeoLocation(),
                    tilt: 17.5,
                    zoom: 17
                  )
                )
              );
             }
          )
        ],
      ),
      body: GoogleMap(
        
        zoomControlsEnabled: false,
        mapType: mapType,
        markers: markers,
        myLocationButtonEnabled: true,
        initialCameraPosition: initialPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.layers),
        onPressed: (){
         
           if(mapType == MapType.normal){

              mapType =  MapType.satellite;
            }else{
              mapType =  MapType.normal;
            }
          setState(() {
           
            
          });
          
        },
      ),
    );
  }
 
}