import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// ignore: unused_import
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:polylines/polyline_Response.dart';

class PolylineScreen extends StatefulWidget {
  const PolylineScreen({Key? key}) : super(key: key);

  @override
  State<PolylineScreen> createState() => _PolylineScreenState();
}

class _PolylineScreenState extends State<PolylineScreen> {
  static const CameraPosition initialPosition = CameraPosition(
    target: LatLng(25.060272,55.20892259999999),
    zoom: 14
    );

    final Set<Marker> _markers = {};

  final Completer<GoogleMapController> _controller = Completer();

  String totalDistance = "";
  String totalTime = ""; 

  String apiKey = "AIzaSyC62Q7AW2KX0yIpll4De0n1AY2vxdCUEWw";

  LatLng origin = const LatLng(25.060272,55.20892259);
  LatLng destination = const LatLng(25.060831,55.2089233);

  PolylineResponse polylineResponse = PolylineResponse();

  Set<Polyline> polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];

//   List<Polyline> _polylines = [
//   Polyline(
//     polylineId: PolylineId('polyline1'),
//     points: [
//       LatLng(37.4219999,-122.0840575),
//       LatLng(37.4221517,-122.0842844),
//       LatLng(37.4222707,-122.0844547),
//       LatLng(37.422296,-122.0845454),
//       LatLng(37.4223784,-122.0847468),
//     ],
//     color: Colors.blue,
//     width: 5,
//   ),
//   Polyline(
//     polylineId: PolylineId('polyline2'),
//     points: [
//       LatLng(37.4221517,-122.0842844),
//       LatLng(37.421827,-122.084132),
//       LatLng(37.421005,-122.083821),
//       LatLng(37.420352,-122.08364),
//       LatLng(37.419709,-122.083417),
//       LatLng(37.419583,-122.083376),
//       LatLng(37.419202,-122.083267),
//     ],
//     color: Colors.red,
//     width: 5,
//   ),
// ];

  late PolylinePoints polylinePoints;

  @override
  void initState() {
    super.initState();
     polylinePoints = PolylinePoints();
     
  }


  List<Routes>? routes;

  @override
  Widget build(BuildContext context) {

    var markers = {
      const Marker(
        markerId: MarkerId('1'),
        position: const LatLng(25.060272,55.20892259),
         ),
        //   Marker(
        // markerId: MarkerId('2'),
        // position: const LatLng(25.060831,55.2089233),
        // icon: BitmapDescriptor.defaultMarkerWithHue(
        //   BitmapDescriptor.hueBlue
        // )
        //  ),
    };
    return Scaffold(
      appBar: AppBar(
        title: const Text("Polyline"),
      ),
      body: Stack(
        children: [
          GoogleMap(
            polylines: Set<Polyline>.of(polylines),
            // polylines: polylines,
            markers: markers,
            zoomControlsEnabled: false,
            initialCameraPosition: initialPosition,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
             
            },
          ),
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Total Distance: $totalDistance"),
                Text("Total Time: $totalTime"),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          postData();
          
        },
        child: const Icon(Icons.directions),
      ),
    );
  }

  // void showPinsonMap() {
  //   setState(() {
  //     _markers.add(Marker(
  //       markerId: MarkerId('sourcePin'),
  //       position: currentLocation,
  //       icon: sourceIcon,
  //       onTap: () {
  //         setState(() {
  //           this.userBadgeSelected = true
  //         });
  //       }
  //       ));

  //       _markers.add(Marker(
  //         markerId: MarkerId('destination'),
  //         position: destinationLocation,
  //         icon: destionationIcon,
  //         onTap: () {
  //           setState(() {
  //             this.pinPillPosition = PIN_VISIBLE_POSITION;
  //           });
  //         },
  //       ));
    // });
  // }

  void postData() async {
    var res = await http.post(Uri.parse('http://ec2-34-197-53-22.compute-1.amazonaws.com:8810/api/v1/nearestdriverlistwb'),
    body: jsonEncode(<dynamic, dynamic> 
    
    {
      
"latitude": "25.0601975",
    "longitude": "55.2093505",
    "drop_latitude": "25.1972295",
    "drop_longitude": "55.279747",
    "motor_model": "1",
    "passenger_id": "327",
    "skip_fav": "0",
    "address": "Current Location",
    "city_name": "",
    "place_id": "",
    "passenger_cid": 7,
    "passenger_app_version": "1.0.0",
    "type": 1



    }));
    if (res.statusCode == 200){
      var reponsedata = json.decode(res.body);
     
      // _customZoneFare = reponsedata ['customZoneFare']; 
     PolylineResponse data = PolylineResponse.fromJson(reponsedata);
      setState(() {
        routes=data.direction?.routes;
        print("CALLING POILYLINE---IN POPST DATA");

        //_loading = false;
      });
      setPolylines();
    }

  // void drawPolyline() async {
  //   var response = await http.post(Uri.parse('http://ec2-34-197-53-22.compute-1.amazonaws.com:8810/api/v1/nearestdriverlistwb'));
  //   //"http://ec2-34-197-53-22.compute-1.amazonaws.com:8810/api/v1/nearestdriverlistwb"
  //     //"http://ec2-34-197-53-22.compute-1.amazonaws.com:8810/api/v1/nearestdriverlistwb" +apiKey+ &units=metric&origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&mode=driving));

  //   print(response.body);
    
  //   polylineResponse = PolylineResponse.fromJson(jsonDecode(response.body));

  //   totalDistance = polylineResponse.direction!.routes![0].legs![0].distance!.text!;
  //   totalTime = polylineResponse.direction!.routes![0].legs![0].duration!.text!;
  // print("Location list ${polylineResponse.direction!.routes!.length}");
  //   for (int i = 0; i < polylineResponse.routes![0].legs![0].steps!.length; i++) {
  //     polylinePoints.add(Polyline(polylineId: PolylineId(polylineResponse.direction!.routes![0].legs![0].steps![i].polyline!.points!),
  //      points: [
  //       LatLng(
  //           polylineResponse.direction!.routes![0].legs![0].steps![i].startLocation!.lat!, 
  //           polylineResponse.direction!.routes![0].legs![0].steps![i].startLocation!.lng!
  //           ),
  //       LatLng(polylineResponse.direction!.routes![0].legs![0].steps![i].endLocation!.lat!, 
  //       polylineResponse.direction!.routes![0].legs![0].steps![i].endLocation!.lng!
  //       ),
  //     ],
  //     width: 5,
  //     color: Colors.blue
  //     ));
  //   }

  //   setState(() {});
  // }
}

  void setPolylines() async{
    try{
 PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      apiKey,
      PointLatLng(
        origin.latitude, 
        origin.longitude
        ),
        PointLatLng(
          destination.latitude, 
          destination.longitude,
          )
      );
print("OUT PUT IN GETPOLYPOINTS ${result.errorMessage}");
      if (result.status == 'OK'){
        print("STATUS OK IN POLYLINE METHOD");
        result.points.forEach((PointLatLng point){
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });

        setState(() {
          polylines.add(
            Polyline(
              polylineId: PolylineId('polyLine'),
              width: 10,
              color: Color(0xFF08A5CB), 
              points: polylineCoordinates, 
            )
          );
        });
      }else{
        print("STATUS NOT OK IN POLYLINE METHOD");
      }
    }catch(error){
print("ERROR OCCURED IN POLYLINE METHOD----${error}");
    }
   
  }
}

//  Set<Marker> _markers() { //markers to place on map
//     setState(() {
//       markers.add(Marker( //add first marker
//         markerId: MarkerId(showLocation.toString()),
//         position: showLocation, //position of marker
//         infoWindow: InfoWindow( //popup info 
//           title: 'Marker Title First ',
//           snippet: 'My Custom Subtitle',
//         ),
//         icon: BitmapDescriptor.defaultMarker, //Icon for Marker
//       ));
//     return markers;
//   }
// }