import 'package:flutter/material.dart';
import 'polyline_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Google Maps"),
        centerTitle: true,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            ElevatedButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                return const PolylineScreen();
              }));
            }, child: const Text("Polyline between 2 points"))
          ],
        ),
      ),
    );
  }
}