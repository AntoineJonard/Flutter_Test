import 'package:flutter/material.dart';
import 'package:flutter_hello_world/Model/MarkModel.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'AllMarkerFound.dart';

class FindPosition extends StatefulWidget {
  final SnackBar _missedSnackBar = SnackBar(content: Text('Missed :('));
  final SnackBar _noMoreMarkerSnackBar =
      SnackBar(content: Text('No more marker to find :)'));

  SnackBar get missedSnackBar => _missedSnackBar;
  SnackBar get noMoreMarkerSnackBar => _noMoreMarkerSnackBar;

  @override
  _FindPositionState createState() => _FindPositionState();
}

class _FindPositionState extends State<FindPosition> {
  GoogleMapController myController;
  final _markers = Set<Marker>();
  double _chrono = 30.00;

  final LatLng home = const LatLng(50.331173, 3.512469);

  bool _stopChrono = false;

  @override
  void initState() {
    incChrono();
  }

  @override
  void dispose() {
    _chrono = -1.00;
    super.dispose();
  }

  Future<void> incChrono() async {
    await Future.delayed(Duration(milliseconds: 100));
    if (this.mounted && !_stopChrono){
      if (_chrono >= 0.00) {
        setState(() {
          _chrono -= 0.1;
          incChrono();
        });
      } else {
        _showNoTimeDialog();
      }
    }
  }

  void onMapCreated(GoogleMapController controller) {
    myController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Find your positions')),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: onMapCreated,
              initialCameraPosition: CameraPosition(
                zoom: 11.0,
                target: home,
              ),
              onLongPress: onLongPress,
              markers: _markers,
            ),
            Positioned(
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                color: Color.fromRGBO(150, 150, 150, 0.7),
                child: Text(
                  'Remaining markers : ${Provider.of<MarkerModel>(context, listen: false).markers.difference(_markers).length}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              top: 70,
              left: 20,
            ),
            Positioned(
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                color: Color.fromRGBO(150, 150, 150, 0.7),
                child: Text(
                  '${_chrono.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              top: 20,
              left: 20,
            ),
          ],
        )
    );
  }

  void onLongPress(LatLng pos) {
    MarkerModel markerModel = Provider.of<MarkerModel>(context, listen: false);
    if (markerModel.markers.difference(_markers).isEmpty)
      Scaffold.of(context).showSnackBar(widget._noMoreMarkerSnackBar);
    for (Marker marker in markerModel.markers.difference(_markers)) {
      if (areClose(pos, marker)) {
        setState(() {
          _markers.add(marker);
        });
        if (markerModel.markers.difference(_markers).isEmpty){
          setState(() {
            _stopChrono = true;
          });
          Navigator.push(context, MaterialPageRoute(builder: (context) => AllMarkerFound()));
        }
        else {
          _showFindDialog();
        }
        return;
      }
    }
    Scaffold.of(context).showSnackBar(widget.missedSnackBar);
  }

  bool areClose(LatLng pos, Marker marker) {
    double earthRadius = 6371000; //meters
    double dLat = degreesToRads(marker.position.latitude - pos.latitude);
    double dLng = degreesToRads(marker.position.longitude - pos.longitude);
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(degreesToRads(pos.latitude)) *
            cos(degreesToRads(marker.position.latitude)) *
            sin(dLng / 2) *
            sin(dLng / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double dist = earthRadius * c;
    if (dist < 1000)
      return true;
    else
      return false;
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
                Text('You\'ve found a marker'),
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

  Future<void> _showNoTimeDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('No More Time'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You are too slow'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('retry'),
              onPressed: () {
                Navigator.of(context).pop();
                _markers.clear();
                _chrono = 30.00;
                incChrono();
              },
            ),
          ],
        );
      },
    );
  }
}