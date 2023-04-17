// // ignore_for_file: import_of_legacy_library_into_null_safe

// import 'package:flutter/material.dart';
// import 'package:google_map_polyline_new/google_map_polyline_new.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:permission/permission.dart';


// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {


//    final Set<Marker> _markers = {};

//    GoogleMapController ? _mapController;

//    final Set<Polyline> polyline = {};

//    List<LatLng> ?routeCords;

//    GoogleMapPolyline googleMapPolyline = new GoogleMapPolyline(apiKey:"AIzaSyC62Q7AW2KX0yIpll4De0n1AY2vxdCUEWw");

//    //Now creating for direction point

//    getDirections()async{
//     var permission = await Permission.getPermissionsStatus([PermissionName.Location]);
//     if (permission[0].permissionStatus == PermissionStatus.notAgain){
//       var askpermissions = await Permission.requestPermissions([PermissionName.Location]);
//     }else{
//      routeCords = await googleMapPolyline.getCoordinatesWithLocation(
//       origin: LatLng(25.060272,55.20892259999999),
//       destination: LatLng(25.1976952,55.28007119999999),
//       mode: RouteMode.driving);
//     }
//    }

//    getaddressNames() async{
//     routeCords = await googleMapPolyline.getPolylineCoordinatesWithAddress(
//       origin: "Jumeirah Village Circle - قرية جميرا - دبي - United Arab Emirates",
//       destination: "57WH+VWJ - Financial Center Rd - Downtown Dubai - Dubai - United Arab Emirates",
//       mode: RouteMode.driving);
//    }

//   @override
//    void initState() {
//      super.initState();
//      getDirections();
     
//    }


//    static CameraPosition _cameraPosition = CameraPosition(
//     target: LatLng(25.060272,55.20892259999999),
//     //LatLng(23.777176, 78.662109),
//     zoom: 11.5,
//   );
 
  

 

//   @override
//   Widget build(BuildContext context) {
//     // var _markers = {
//     //   const Marker(
//     //     markerId: MarkerId('1'),
//     //     position: consst LatLng(11.043796, 77.03834),
//     //      ),
//     // };
//     return   Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.lightBlue[400],
//           centerTitle: true,
//           title: Text("Google Map",
//           style:TextStyle(
//             fontWeight: FontWeight.bold
//           )),
//         ),
//          body: GoogleMap(
//           mapType: MapType.normal,
//          onMapCreated: _onMapCreated,
//         initialCameraPosition: _cameraPosition,
//         markers: _markers,
//         // myLocationButtonEnabled: true,
//         // padding: EdgeInsets.only(bottom: 50.0),
//         // minMaxZoomPreference: MinMaxZoomPreference(4, 18),
//       ),
//     );
//   }
//   void _onMapCreated(GoogleMapController controller) {
//     setState(() {
//       _mapController = controller;

//       polyline.add(Polyline(
//         polylineId: PolylineId('route1'),
//         visible: true,
//         points: routeCords!,
//         width: 5,
//         color: Colors.blue,
//         ));
//     });
//   }
// }

 
