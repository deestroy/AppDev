import 'dart:async';
import 'dart:io';

//import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' show join;
//import 'package:flutter_firebase_storage/firebase_storage_util.dart';


//import '../../main.dart';
//import '../detector_painters.dart';

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


  //File _imageFile;
  //Size _imageSize;
  //dynamic _scanResults;
  //Detector _currentDetector = Detector.label;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    //Initialize the controller. This returns a Future
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      //button to take picture
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () async {
          try {

            // Ensure the camera is initialized
            await _initializeControllerFuture;
            // Construct the path where the image should be saved using the path package
            final path = join(
              // In this example, store the picture in the temp directory. Find
              // the temp directory using the `path_provider` plugin.
              (await getTemporaryDirectory()).path,
              '${DateTime.now()}.png',
            );

            // upload a file on Firebase storage
           //var storageRef = firebase.storage.ref("folderName/file.jpg");
          
            /*Process.run('ls', ['-l']).then((ProcessResult results) {
              print(results.stdout);
              print('running...');
            });*/
            // Attempt to take a picture and log where it's been saved
            await _controller.takePicture(path);
            // If the picture was taken, display it on a new screen
            // detect(path);
            

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(imagePath: path),
              ),
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
      ),
    );
  }
}

// A Widget that displays the picture taken by the user
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  // @override
  // State<StatefulWidget> createState() {
  //   return DisplayScreenState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                          color: Colors.black,
                          onPressed: () {
                            print("pressed");
                            // update food and go back to dashboard,
                          }),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
