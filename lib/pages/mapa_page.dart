import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapaPage extends StatefulWidget {
  const MapaPage({super.key});


  @override
  // ignore: library_private_types_in_public_api
  _MapaPageState createState() => _MapaPageState();
}

class  _MapaPageState extends State<MapaPage> {

  final Completer<GoogleMapController> _controller = Completer();
  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {


    const CameraPosition untoInitial =  CameraPosition(
        target: LatLng(0, 0),
        zoom: 17.5,
        tilt: 50
    );

    // Marcadores
    Set<Marker> markers =  <Marker>{};
    markers.add(const Marker(
        markerId: MarkerId('geo-location'),
        position: LatLng(0, 0)
    ));


    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa'),
        actions: [
          IconButton(
              icon: const Icon( Icons.location_disabled),
              onPressed: () async {
                final GoogleMapController controller = await _controller.future;
                controller.animateCamera(
                    CameraUpdate.newCameraPosition(
                        const CameraPosition(
                            target: LatLng(0, 0),
                            zoom: 17.5,
                            tilt: 50
                        )
                    )
                );
              }
          )
        ],
      ),
      body: GoogleMap(
        myLocationButtonEnabled: false,
        mapType: mapType,
        markers: markers,
        initialCameraPosition: untoInitial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon( Icons.layers ),
          onPressed: () {

            if ( mapType == MapType.normal ) {
              mapType = MapType.satellite;
            } else {
              mapType = MapType.normal;
            }

            setState(() {});
          }
      ),
    );
  }
}
