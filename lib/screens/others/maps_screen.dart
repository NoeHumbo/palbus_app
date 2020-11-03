import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:palbus_app/database/route_list.dart';

class MapsScreen extends StatefulWidget {
  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  Marker _marker = new Marker(
    markerId: MarkerId('1'),
    position: LatLng(-5.182786, -80.623684),
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
      polylines: RouteList.listLatLng(),
      markers: {_marker},
    );
  }
}
