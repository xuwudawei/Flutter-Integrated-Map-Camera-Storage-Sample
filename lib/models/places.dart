import 'dart:ffi';
import 'dart:io';

class PlaceLocation {
  double longitude;
  double latitude;
  String address;
  PlaceLocation({
    required this.address,
    required this.latitude,
    required this.longitude,
  });
}

class Places {
  String id;
  String title;
  PlaceLocation location;
  File image;

  Places({
    required this.id,
    required this.title,
    required this.image,
    required this.location,
  });
}
