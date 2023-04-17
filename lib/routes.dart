// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class HomePage extends StatefulWidget {
//   final LatLng startPoint;
//   final LatLng endPoint;
  
//   HomePage({
//     required this. startPoint,
//     required this.endPoint,
//   });

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   late GoogleMapController mapController;
//   late Map<PolylineId, Polyline> polylines;

//   @override
//   void initState() {
//     super.initState();
//     polylines = {};
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;

//     setState(() {
//       final polylineId = PolylineId('route');
//       final polyline = Polyline(
//          polylineId: polylineId,
//         color: Colors.blue,
//         points: [widget.startPoint, widget.endPoint],
//       );
//       polylines[polylineId] = polyline;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Map'),
//       ),
//       body: GoogleMap(
//         onMapCreated: _onMapCreated,
//         polylines: Set<Polyline>.of(polylines.values),
//         initialCameraPosition: CameraPosition(
//           target: widget.startPoint,
//           zoom: 15,
//         ),
//       ),
//     );
//   }
// }