import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:places_app/helpers/db_helper.dart';

import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String inputTitle, File pickedImage) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: inputTitle,
      image: pickedImage,
      location: null,
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert(
      "user_places",
      {
        "id": newPlace.id,
        "title": newPlace.title,
        "image": newPlace.image.path
      },
    );
  }

  Future<void> fetchAndSetPlace() async {
    final dataList = await DBHelper.getData("user_places");
    _items = dataList
        .map(
          (item) => Place(
            id: item["id"],
            title: item["title"],
            image: File(item["image"]),
            location: null,
          ),
        )
        .toList();
    notifyListeners();
  }
}
