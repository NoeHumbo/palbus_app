import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:palbus_app/database/route_list.dart';

class MapsScreen extends StatefulWidget {
  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  double latitude = -5.182909;
  double longitude = -80.633246;

  final status = Permission.location.request();
  bool statusGPS = false;
  bool activeGPS = false;

  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
    accesoGPS();
    position();
  }

  accesoGPS() async {
    if (await status.isGranted) {
      setState(() => this.statusGPS = true);
    }
  }

  position() async {
    bool activeGPS = await geolocator.Geolocator.isLocationServiceEnabled();
    if (activeGPS) {
      geolocator.Position position = await geolocator.Geolocator.getCurrentPosition();
      setState(() {
        this.latitude = position.latitude;
        this.longitude = position.longitude;
        this.activeGPS = true;
      });
    }
  }

  Marker marker() {
    return new Marker(
      markerId: MarkerId('1'),
      position: LatLng(latitude, longitude),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: statusGPS ? buildGoogleMap() : buildButtonAccessGPS(),
      ),
    );
  }

  Center buildButtonAccessGPS() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Es neceario dar acceso del GPS'),
          MaterialButton(
            onPressed: () {
              openAppSettings();
            },
            child: Text(
              'Solicitar accesso GPS',
              style: TextStyle(color: Colors.white),
            ),
            elevation: 0,
            splashColor: Colors.transparent,
            color: Colors.blue,
            shape: StadiumBorder(),
          ),
        ],
      ),
    );
  }

  buildGoogleMap() {
    final cameraPosition = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 16,
    );
    return GoogleMap(
      initialCameraPosition: cameraPosition,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      mapType: MapType.normal,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      zoomControlsEnabled: true,
      polylines: RouteList.listLatLng(),
      markers: activeGPS ? {marker()} : null,
    );
  }
}
