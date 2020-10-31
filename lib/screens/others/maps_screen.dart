import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsScreen extends StatefulWidget {
  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  Polyline _miRuta = new Polyline(
      polylineId: PolylineId('1'),
      color: Colors.black,
      width: 5,
      points: <LatLng>[
        LatLng(-5.182909, -80.633246),
        LatLng(-5.183909, -80.633246),
        LatLng(-5.183909, -80.635246)
      ]);

  Marker _miMarcador = new Marker(
    markerId: MarkerId('1'),
    position: LatLng(-5.183909, -80.635246),
  );

  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: buildGoogleMap()),
    );
  }

  buildGoogleMap() {
    final cameraPosition = CameraPosition(
      target: LatLng(-5.182909, -80.633246),
      zoom: 15,
    );
    return GoogleMap(
      initialCameraPosition: cameraPosition,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      mapType: MapType.normal,
      myLocationEnabled: false,
      myLocationButtonEnabled: true,
      zoomControlsEnabled: true,
      polylines: {_miRuta},
      markers: {_miMarcador},
    );
  }
}
