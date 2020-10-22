import 'package:flutter/material.dart';
import 'package:flutter_hello_world/Model/MarkModel.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'dart:math';


class FindPosition extends StatefulWidget {
  final SnackBar _missedSnackBar = SnackBar(content: Text('Missed :('));
  final SnackBar _noMoreMarkerSnackBar = SnackBar(content: Text('No more marker to find :)'));

  SnackBar get missedSnackBar => _missedSnackBar;
  SnackBar get noMoreMarkerSnackBar => _noMoreMarkerSnackBar;
  
  @override
  _FindPositionState createState() => _FindPositionState();

}

class _FindPositionState extends State<FindPosition> {
  GoogleMapController myController;
  final _markers = Set<Marker>();

  final LatLng home = const LatLng(50.331173, 3.512469);

  void onMapCreated(GoogleMapController controller) {
    myController = controller;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find your positions')
      ),
      body: GoogleMap(
        onMapCreated: onMapCreated,
        initialCameraPosition: CameraPosition(
          zoom: 11.0,
          target: home,
        ),
        onLongPress: onLongPress,
        markers: _markers,
      ),
    );
  }

  void onLongPress(LatLng pos) {
    MarkerModel markerModel = Provider.of<MarkerModel>(context, listen: false);
    if (markerModel.markers.difference(_markers).isEmpty) Scaffold.of(context).showSnackBar(widget._noMoreMarkerSnackBar);
    for (Marker marker in markerModel.markers.difference(_markers)){
      if (areClose(pos, marker)) {
        setState(() {
          _markers.add(
            marker
          );
        });
        _showFindDialog();
      }
      else {
        Scaffold.of(context).showSnackBar(widget.missedSnackBar);
      }
    }
  }

  bool areClose(LatLng pos, Marker marker) {
    double earthRadius = 6371000; //meters
    double dLat = degreesToRads(marker.position.latitude-pos.latitude);
    double dLng = degreesToRads(marker.position.longitude-pos.longitude);
    double a = sin(dLat/2) * sin(dLat/2) +
        cos(degreesToRads(pos.latitude)) * cos(degreesToRads(marker.position.latitude)) *
            sin(dLng/2) * sin(dLng/2);
    double c = 2 * atan2(sqrt(a), sqrt(1-a));
    double dist = earthRadius * c;
    if (dist < 1000) return true;
    else return false;
  }

  num degreesToRads(num deg) {
    return (deg * pi) / 180.0;
  }

  Future<void> _showFindDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Good Job !'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You\'ve found your first maker'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('continue to find'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}