import 'package:flutter/material.dart';
import 'package:location_app/Helpers/db_helper.dart';
import 'package:location_app/models/places.dart';
import 'dart:io';

class PlaceProvider with ChangeNotifier {
  List<Places> _places = [];

  List<Places> get places {
    return [..._places];
  }

  void addPlace(String pickedTitle, File pickedImage) {
    final newPlace = Places(
      id: DateTime.now().toString(),
      title: pickedTitle,
      image: pickedImage,
      location: PlaceLocation(
        latitude: 0,
        longitude: 0,
        address: "",
      ),
    );
    _places.add(newPlace);
    notifyListeners();
    DBHELPER.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      
    });
  }

  Future<void> fetchAllPlacesAndSet() async {
    final dataList = await DBHELPER.getAllPlacesData('user_places');
    _places = dataList
        .map(
          (item) => Places(
              id: item['id'],
              title: item['title'],
              image: File(item['image']),
              location: PlaceLocation(latitude: 0, longitude: 0, address: "")),
        )
        .toList();
  }
}
