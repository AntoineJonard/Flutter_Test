import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'Model/MarkModel.dart';

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State{
  GoogleMapController myController;

  final LatLng home = const LatLng(50.331173, 3.512469);

  void onMapCreated(GoogleMapController controller) {
    myController = controller;
  }

  void onLongPres(LatLng pos) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => AddNewMarker(pos)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
      ),
      body: GoogleMap(
        onMapCreated: onMapCreated,
        initialCameraPosition: CameraPosition(
          target: home,
          zoom: 11.0
        ),
        onLongPress: onLongPres,
        markers: Provider.of<MarkerModel>(context).markers,
      ),
    );
  }
}

class AddNewMarker extends StatefulWidget{
  final LatLng _pos;

  AddNewMarker(this._pos);

  @override
  _AddNewMarkerState createState() {
    return _AddNewMarkerState();
  }

}

class _AddNewMarkerState extends State<AddNewMarker>{
  TextEditingController _controller;

  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Marker'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
        onPressed: () => {
          Provider.of<MarkerModel>(context, listen: false).addMarker(
            Marker(
              markerId: MarkerId(
                  _controller.value.text
              ),
              position: widget._pos,
              infoWindow: InfoWindow(
                title: _controller.value.text
              )
            )
          )
        },
      ),
      body: Center(
        child: TextField(
          controller: _controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Name',
          ),
        ),
      ),
    );
  }
}