import 'dart:math';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hello_world/Model/NameModel.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'Model/MarkModel.dart';

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State {
  GoogleMapController myController;

  final LatLng home = const LatLng(50.331173, 3.512469);

  void onMapCreated(GoogleMapController controller) {
    myController = controller;
  }

  void onLongPres(LatLng pos) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => AddNewMarker(pos)),
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
        initialCameraPosition: CameraPosition(target: home, zoom: 11.0),
        onLongPress: onLongPres,
        markers: Provider.of<MarkerModel>(context).markers,
      ),
    );
  }
}

class AddNewMarker extends StatefulWidget {
  final LatLng _pos;

  AddNewMarker(this._pos);

  @override
  _AddNewMarkerState createState() {
    return _AddNewMarkerState();
  }
}

class _AddNewMarkerState extends State<AddNewMarker> {
  String dropdownValue;

  static final textStyle = TextStyle(
    fontSize: 35,
    fontStyle: FontStyle.italic,
    color: Color.fromRGBO(105, 105, 105, 1),
  );

  @override
  Widget build(BuildContext context) {
    NameModel nameModel = Provider.of<NameModel>(context, listen: false);
    if ((dropdownValue == null || dropdownValue.isEmpty) &&
        nameModel.saved.isNotEmpty)
      dropdownValue = nameModel.saved.first.asCamelCase;
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Marker'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
        onPressed: addMarkerName,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Position\'s name',
              style: textStyle,
            ),
            SizedBox(height: 20),
            Icon(
              Icons.drive_file_rename_outline,
              size: 50,
            ),
            SizedBox(height: 30),
            DropdownButton<String>(
              value: dropdownValue,
              items:
                  Provider.of<NameModel>(context).getSavedNamesAsDropDownString(),
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue = newValue;
                });
              },
              style: textStyle,
              underline: Container(
                height: 2,
                color: Colors.deepPurple,
              ),
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 30,
            )
          ],
        )
      ),
    );
  }

  addMarkerName() {
    if (dropdownValue != null && dropdownValue.isNotEmpty) {
      Provider.of<MarkerModel>(context, listen: false).addMarker(Marker(
          markerId: MarkerId(dropdownValue),
          position: widget._pos,
          infoWindow: InfoWindow(title: dropdownValue)));
      setState(() {
        NameModel nameModel = Provider.of<NameModel>(context, listen: false);
        nameModel.removeNameFromString(dropdownValue);
        if (nameModel.saved.isNotEmpty)
          dropdownValue = nameModel.saved.first.asCamelCase;
        else
          dropdownValue = 'no more names';
      });
      Navigator.pop(context);
    }
  }
}
