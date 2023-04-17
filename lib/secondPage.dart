import 'dart:async';
import 'dart:convert';
//import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:polylines/polyline_Response.dart';
import 'package:http/http.dart'as http;

// class HomePage extends StatefulWidget {

// @override
// _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {


// // created controller to display Google Maps
// Completer<GoogleMapController> _controller = Completer();


// //on below line we have set the camera position
// static final CameraPosition _cameraPosition = const CameraPosition(
// 	target: LatLng(25.060272,55.20892259999999),
// 	zoom: 14,
// );

// final Set<Marker> _markers = {};
// final Set<Polyline> _polyline = {};

// // list of locations to display polylines
// List<LatLng> latLen = [
//    LatLng(25.1626382,55.26276530000001),
// 	 LatLng(25.1976952,55.28007119999999),
// 	 LatLng(25.060272,55.20892259999999),
//    LatLng(25.0685206,55.2033431),
//    //LatLng(23.777176, 78.662109),
// ];



// @override
// void initState() {
// 	// TODO: implement initState
// 	super.initState();

// 	// declared for loop for various locations
// 	for(int i=0; i<latLen.length; i++){
// 	_markers.add(
// 		// added markers
// 		Marker(
// 			markerId: MarkerId(i.toString()),
// 		position: latLen[i],
// 		// infoWindow: InfoWindow(
// 		// 	title: 'Financial Center Rd - Downtown Dubai',
// 		// 	snippet: 'Dubai - United Arab Emirates',
// 		// ),
// 		//icon: BitmapDescriptor.defaultMarker,
// 		 )
// 	);
// 	// setState(() {

// 	// });
// 	_polyline.add(
// 		Polyline(
// 			polylineId: PolylineId('1'),
// 			points: latLen,
//       width: 5,
// 			color: Colors.blue,
// 		)
// 	);
// 	}
// }

// @override
// Widget build(BuildContext context) {
// 	return Scaffold(
// 	appBar: AppBar(
// 		backgroundColor: Colors.lightBlue,
//     // (0xFF0F9D58),
// 		// title of app
//     centerTitle: true,
// 		title: Text("Google Map",
//           ),
//         ),
// 	body: Container(
// 		child: SafeArea(
// 		child: GoogleMap(
// 			//given camera position
// 			initialCameraPosition: _cameraPosition,
// 			// on below line we have given map type
// 			mapType: MapType.normal,
// 			// specified set of markers below
// 			markers: _markers,
// 			// on below line we have enabled location
// 			myLocationEnabled: true,
// 			myLocationButtonEnabled: true,
// 			// on below line we have enabled compass location
// 			compassEnabled: true,
// 			// on below line we have added polylines
// 			polylines: _polyline,
// 			// displayed google map
// 			onMapCreated: (GoogleMapController controller){
// 				_controller.complete(controller);
// 			},
// 		),
// 		),
// 	),
// );
// }
// }


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  static final CameraPosition _cameraPosition = const CameraPosition(
	target: LatLng(25.060272,55.20892259999999),
	zoom: 14,
);


  PolylineResponse polylineResponse = PolylineResponse();
  Set<Polyline> polylinePoints = {};
  final Completer<GoogleMapController> _controller = Completer();
  String apiKey = "";
  var totalDistance = "";
  var totalTime = ""; 

  LatLng origin = LatLng(25.1995928,55.28007119999999);
  LatLng destination = LatLng(25.0595486,55.1993994);
  //double _originLatitude = 25.1995928, _originLongitude = 55.28007119999999;
  //double _destLatitude = 25.060831, _destLongitude = 55.2089233;
  Map<MarkerId, Marker> markers = {};
  //Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  //PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyC62Q7AW2KX0yIpll4De0n1AY2vxdCUEWwnn";

  @override
  void initState() {
    super.initState();

    /// origin marker
    // _addMarker(LatLng(_originLatitude, _originLongitude), "origin",
    //     BitmapDescriptor.defaultMarker);

    /// destination marker
    // _addMarker(LatLng(_destLatitude, _destLongitude), "destination",
    //     BitmapDescriptor.defaultMarkerWithHue(90));
    //_getPolyline();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Stack(
            children:[ GoogleMap(
              mapType: MapType.normal,
                  initialCameraPosition: _cameraPosition,
                  // CameraPosition(target: LatLng(_originLatitude, _originLongitude), zoom: 15),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  tiltGesturesEnabled: true,
                  compassEnabled: true,
                  // scrollGesturesEnabled: true,
                  zoomGesturesEnabled: true,
                  onMapCreated: _onMapCreated,
                  markers: Set<Marker>.of(markers.values),
                  //polylines: Set<Polyline>.of(polylines.values),
                ),

              Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Total Distance:" + totalDistance),
                    Text("Total Time:" + totalTime),
                  ],
                ),
              ),
          ]
          ),
          // floatingActionButton: FloatingActionButton(
          //   child: Icon(Icons.directions),
          //   onPressed:(){}
          //   //drawPolyline(),
          // ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
   _controller.complete(controller);
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }
  
  drawPolyline() async{
    var response = await http.post(Uri.parse("http://ec2-34-197-53-22.compute-1.amazonaws.com:8810/api/v1/nearestdriverlistwb" + apiKey +
    origin.latitude.toString() + "," + origin.longitude.toString() +
    "&destination=" + destination.latitude.toString() + "," + destination.longitude.toString() + "&mode=driving"
    ));

    polylineResponse = PolylineResponse.fromJson(jsonDecode(response.body));
    print("MY ROUTES : ${polylineResponse.routes?.length}");

    totalDistance = polylineResponse.direction!.routes![0].legs![0].distance!.text!;
    totalTime = polylineResponse.direction!.routes![0].legs![0].distance!.text!;

    setState(() {
      
    });
  }

  // _addPolyLine() {
  //   PolylineId id = PolylineId("poly");
  //   Polyline polyline = Polyline(
  //       polylineId: id,
  //       width:5,
  //       points: polylineCoordinates);
  //   polylines[id] = polyline;
  //   setState(() {});
  // }
  // _getPolyline() async {
  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //       googleAPiKey,
  //       PointLatLng(_originLatitude, _originLongitude),
  //       PointLatLng(_destLatitude, _destLongitude),
  //       travelMode: TravelMode.driving,
  //       wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")]);
  //   if (result.points.isNotEmpty) {
  //     result.points.forEach((PointLatLng point) {
  //       polylineCoordinates.add(LatLng(point.latitude, point.longitude));
  //     });
  //   }
  //   _addPolyLine();}
}