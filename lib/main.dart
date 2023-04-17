import 'package:flutter/material.dart';
import 'package:polylines/polylines/polyline_screen.dart';
import 'package:polylines/secondPage.dart';
//import 'package:polylines/routes.dart';
//import 'package:polylines/homePage.dart';
//import 'package:polylines/secondPage.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.lightBlue
          // fromARGB(255, 47, 62, 95)
        )
      ),
      debugShowCheckedModeBanner: false,
      home: PolylineScreen()
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// void main(){
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Home(),
//     );
//   }
// }

// class Home extends StatefulWidget{
//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {

//   GoogleMapController? mapController; //contrller for Google map
//   PolylinePoints polylinePoints = PolylinePoints();

//   String googleAPiKey = "AIzaSyC62Q7AW2KX0yIpll4De0n1AY2vxdCUEWw";

//   Set<Marker> markers = Set(); //markers for google map
//   Map<PolylineId, Polyline> polylines = {}; //polylines to show direction

//   LatLng startLocation = LatLng(25.060272,55.20892259999999);  
//   LatLng endLocation = LatLng(25.1976952,55.28007119999999); 
                            

//   @override
//   void initState() {

//      markers.add(Marker( //add start location marker
//         markerId: MarkerId(startLocation.toString()),
//         position: startLocation, //position of marker
//         infoWindow: InfoWindow( //popup info 
//           title: 'Starting Point ',
//           snippet: 'Start Marker',
//         ),
//         icon: i BitmapDescriptor.defaultMarker, //Icon for Marker
//       ));

//       markers.add(Marker( //add distination location marker
//         markerId: MarkerId(endLocation.toString()),
//         position: endLocation, //position of marker
//         infoWindow: InfoWindow( //popup info 
//           title: 'Destination Point ',
//           snippet: 'Destination Marker',
//         ),
//         icon: BitmapDescriptor.defaultMarker, //Icon for Marker
//       ));
      
//       getDirections(); //fetch direction polylines from Google API
      
//     super.initState();
//   }

//   getDirections() async {
//       List<LatLng> polylineCoordinates = [];
     
//       PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//           googleAPiKey,
//          const PointLatLng(25.060272,55.20892259999999),
//          const PointLatLng(25.1976952,55.28007119999999),
//           travelMode: TravelMode.driving,
//       );
//       print("my points");
//       print(result.points);

//       if (result.points.isNotEmpty) {
//             result.points.forEach((PointLatLng point) {
//                 polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//             });
//       } else {
//          print(result.errorMessage);
//       }
//       addPolyLine(polylineCoordinates);
//   }

//   addPolyLine(List<LatLng> polylineCoordinates) {
//     PolylineId id = PolylineId("poly");
//     Polyline polyline = Polyline(
//       polylineId: id,
//       color: Colors.deepPurpleAccent,
//       points: polylineCoordinates,
//       width: 8,
//     );
//     polylines[id] = polyline;
//     setState(() {});
//   }  

//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//           appBar: AppBar( 
//              title: Text("Google Map"),
//              backgroundColor: Colors.deepPurpleAccent,
//           ),
//           body: GoogleMap( //Map widget from google_maps_flutter package
//                     zoomGesturesEnabled: true, //enable Zoom in, out on map
//                     initialCameraPosition: CameraPosition( //innital position in map
//                       target: startLocation, //initial position
//                       zoom: 16.0, //initial zoom level
//                     ),
//                     markers: markers, //markers to show on map
//                     polylines: Set<Polyline>.of(polylines.values), //polylines
//                     mapType: MapType.normal, //map type
//                     onMapCreated: (controller) { //method called when map is created
//                       setState(() {
//                         mapController = controller; 
//                       });
//                     },
//               ),
//        );
//   }
// }


