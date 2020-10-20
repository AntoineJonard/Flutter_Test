import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerModel extends ChangeNotifier{
  final _markers = Set<Marker>();

  Set<Marker> get markers => _markers;

  void addMarker(Marker marker){
    _markers.add(marker);
    notifyListeners();
  }
}