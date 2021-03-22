

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  double latitude=0;
  double longitude=0;
  void getCurrentLocation() async
  {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      latitude =position.latitude;
      longitude =position.longitude;
      print(position);
    } catch (e) {
      print(e);
    }
  }
}
