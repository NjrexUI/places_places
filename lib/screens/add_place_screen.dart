import 'dart:io';

import 'package:flutter/material.dart';
import 'package:places_app/widgets/location_input.dart';
import 'package:provider/provider.dart';

import '../widgets/image_input.dart';
import '../providers/places.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = "/add-place";

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final titleController = TextEditingController();
  File _pickedImage;

  void selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void savePlace() {
    if (titleController.text.isEmpty || _pickedImage == null) {
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false).addPlace(
      titleController.text,
      _pickedImage,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Place"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: "Title"),
                      controller: titleController,
                    ),
                    SizedBox(height: 10),
                    ImageInput(selectImage),
                    SizedBox(height: 10),
                    LocationInput(),
                  ],
                ),
              ),
            ),
          ),
          // ignore: deprecated_member_use
          RaisedButton.icon(
            color: Theme.of(context).accentColor,
            icon: Icon(Icons.add),
            label: Text("Add Place"),
            onPressed: savePlace,
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );
  }
}
