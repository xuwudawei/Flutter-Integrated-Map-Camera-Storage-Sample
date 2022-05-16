import 'package:flutter/material.dart';
import 'package:location_app/Providers/place.dart';
import 'dart:io';
import 'package:location_app/widgets/image_input.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  TextEditingController _titleController = TextEditingController();
  File? _selectedImage;
  void onSelectImage(File? image) {
    _selectedImage = image;
  }

  void _savePlace() {
    if (_titleController.text.isEmpty || _selectedImage == null) {
      return;
    }
    Provider.of<PlaceProvider>(context, listen: false)
        .addPlace(_titleController.text, _selectedImage!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add A Place"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        controller: _titleController,
                        decoration: InputDecoration(labelText: "Title"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ImageInput(onSelectImage: onSelectImage),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _savePlace,
              child: Text("+ Add New Place"),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                padding: EdgeInsets.zero,
                minimumSize: Size(MediaQuery.of(context).size.width, 60),
                primary: Theme.of(context).accentColor,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ],
        ));
  }
}
