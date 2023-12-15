import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsAdress extends StatefulWidget {
  final double latitude;
  final double longitude;

  const GoogleMapsAdress({Key? key, required this.latitude, required this.longitude})
      : super(key: key);

  @override
  State<GoogleMapsAdress> createState() => _GoogleMapsAdressState();
}

class _GoogleMapsAdressState extends State<GoogleMapsAdress> {

  /*Set<Marker> _marker = {};

  _loadMarker() {
    Set<Marker> _listMarker = [];
    Marker marker1 = Marker(

      markerId: MarkerId('marker-Id'),
      position: LatLng(latitude, longitude)
    ),
  }
*/
  @override
  Widget build(BuildContext context) {
    return Container(
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            zoom: 17,

            target: LatLng(widget.latitude, widget.longitude),

          ),
        ),
      );
  }
}
