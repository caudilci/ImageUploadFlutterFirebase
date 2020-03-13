import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_upload/models/user.dart';
import 'package:image_upload/services/database.dart';
import 'package:provider/provider.dart';

class ImageCapture extends StatefulWidget {
  @override
  _ImageCaptureState createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://mystoragebucketname.appspot.com');

  StorageUploadTask _uploadTask;
  File _imageFile;
  String _downloadURL;

  Future<String> _startUpload() async {
    /// Unique file name for the file
    String filePath = 'images/${DateTime.now()}.png';
    _uploadTask = _storage.ref().child(filePath).putFile(_imageFile);
    StorageTaskSnapshot storageTaskSnapshot = await _uploadTask.onComplete;
    return await storageTaskSnapshot.ref.getDownloadURL();
  }

  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);

    setState(() {
      _imageFile = selected;
    });
  }

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
        sourcePath: _imageFile.path,);

    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  void _clear() {
    setState(() {
      _imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[800],
        leading: FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.clear)),
        title: Text('Choose Picture'),
        centerTitle: true,
        elevation: 0.0,
        actions: <Widget>[
          FlatButton(
            onPressed: () async {
              if (_imageFile != null) {
                _downloadURL = await _startUpload();
                DatabaseService(uid: user.uid).updateUserData(_downloadURL);
                Navigator.pop(context);
              }
            },
            child: Icon(Icons.check),
          )
        ],
      ),

      // Preview the image and crop it
      body: ListView(
        children: <Widget>[
          if (_imageFile != null) ...[
            Image.file(_imageFile),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  child: Icon(Icons.crop),
                  onPressed: _cropImage,
                ),
                FlatButton(
                  child: Icon(Icons.refresh),
                  onPressed: _clear,
                ),
              ],
            ),
          ] else ...[
            RaisedButton(
                onPressed: () => _pickImage(ImageSource.camera),
                child: Icon(Icons.photo_camera)),
            RaisedButton(
              onPressed: () => _pickImage(ImageSource.gallery),
              child: Icon(Icons.photo_library),
            ),
          ]
        ],
      ),
    );
  }
}
