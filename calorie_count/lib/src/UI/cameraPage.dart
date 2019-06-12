import 'dart:async';
import 'dart:io';

import 'package:calorie_count/main.dart';
import 'package:calorie_count/src/database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' show join;
import 'package:zoomable_image/zoomable_image.dart';

class CameraPage extends StatefulWidget {
  final CameraDescription camera;

  const CameraPage({
    Key key,
    @required this.camera,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CameraPageState();
  }
}

class CameraPageState extends State<CameraPage> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    //Initialize the controller
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //preview of camera
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      //button to take picture
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            // Construct the path where the image should be saved using the path package
            final path = join(
              (await getTemporaryDirectory()).path,
              '${DateTime.now()}.png',
            );
            // Attempt to take a picture and log where it's been saved
            await _controller.takePicture(path);
            // If the picture was taken, display it on a new screen
            //  getImage(path);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DisplayPictureScreen(imagePath: path)));
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
      ),
    );
  }
}

class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;
  DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DisplayPictureScreenState(imagePath: imagePath);
  }
}

// A Widget that displays the picture taken by the user
class DisplayPictureScreenState extends State<DisplayPictureScreen> {
  final String imagePath;

  DisplayPictureScreenState({Key key, this.imagePath});

  File pictureTaken;
  String fileName, downloadURL;
  bool uploaded = false;
  final StreamController<bool> streamControl = StreamController<bool>();

  Future getImage(String path) async {
    var tempImage = File(path);

    setState(() {
      pictureTaken = tempImage;
      fileName = basename(pictureTaken.path);
    });

    final StorageReference storageref =
        FirebaseStorage.instance.ref().child(fileName);
    final StorageUploadTask task = storageref.putFile(pictureTaken);
    StorageTaskSnapshot taskSnapshot = await task.onComplete;

    downloadImage(fileName);
  }

  Future downloadImage(String fileName) async {
    String downloadAddress =
        await FirebaseStorage.instance.ref().child(fileName).getDownloadURL();

    setState(() {
      downloadURL = downloadAddress;
      streamControl.sink.add(uploaded = true);
      print("$downloadURL");
    });
  }

  @override
  void dispose() {
    streamControl.close();
    super.dispose();
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _showSnackBar() {
    final snackBar = new SnackBar(
      content: new Text("Processing Image"),
      duration: new Duration(seconds: 10),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    // just diplay picture that was just taken
    
    return Scaffold(
      key: _scaffoldKey,
        body: StreamBuilder<bool>(
            stream: streamControl.stream,
            builder: (context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.data == true) {
                //image uploaded
                return Container(
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Image.network(downloadURL),
                          Positioned(
                            child: Padding(
                              padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: BackButton(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 5.0,
                            child: Padding(
                              padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: IconButton(
                                    icon: Icon(Icons.done, size: 30.0),
                                    color: Colors.red,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) => HomePage(
                                                  camera: cameras.first)));
                                    }),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                //not uploaded
                return Container(
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Image.file(File(imagePath)),
                          Positioned(
                            child: Padding(
                              padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: BackButton(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 5.0,
                            child: Padding(
                              padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: IconButton(
                                    icon: Icon(Icons.done, size: 30.0),
                                    color: Colors.green,
                                    onPressed: () {
                                      _showSnackBar();
                                      getImage(imagePath); //uploads picture to firebase and downloads URL
                                    }),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }
            }));
  }// build
}
