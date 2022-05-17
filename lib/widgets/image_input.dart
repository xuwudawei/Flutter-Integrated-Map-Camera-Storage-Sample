import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function? onSelectImage;
  const ImageInput({Key? key, this.onSelectImage}) : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  String? _imagePath;

  Future<void> _takePicture() async {
    final _picker = ImagePicker();
    final _imageCropper = ImageCropper();
    try {
      final takenPic = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 600,
      );
      if (takenPic != null) {
        final croppedPic = await _imageCropper.cropImage(
          sourcePath: takenPic.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false,
            ),
          ],
        );
        if (croppedPic != null) {
          Directory appDir = await syspaths.getApplicationDocumentsDirectory();
          String fileName = path.basename(croppedPic.path);
          File croppedPicFile = File(croppedPic.path);
          File savedPic = await croppedPicFile.copy('${appDir.path}/$fileName');
          widget.onSelectImage!(savedPic);

          setState(() {
            _imagePath = croppedPic.path;
          });
        } else {
          print('Failed to crop the original image.');
          return;
        }
      } else {
        print("Failed to take picture, file is null");
        return;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 100,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _imagePath == null
              ? Text(
                  "No Image Selected",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                )
              : Image.file(
                  File(_imagePath!),
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
            ),
            onPressed: _takePicture,
            child: RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: Icon(Icons.camera),
                  ),
                  TextSpan(
                    text: 'Take a Picture',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
