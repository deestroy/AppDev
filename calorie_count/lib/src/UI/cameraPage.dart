import 'dart:async';
import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' show join;

import '../../main.dart';
import '../detector_painters.dart';

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

  File _imageFile;
  Size _imageSize;
  dynamic _scanResults;
  Detector _currentDetector = Detector.label;

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

  // detect(String path) {

  //  Future<void> getImageSize(File imageFile) async {
  //    final Completer<Size> completer = Completer<Size>();

  //    final Image image = Image.file(imageFile);
  //    image.image.resolve(const ImageConfiguration()).addListener(
  //      (ImageInfo info, bool _) {
  //        completer.complete(Size(
  //          info.image.width.toDouble(),
  //          info.image.height.toDouble(),
  //        ));
  //      },
  //    );
  //    final Size imageSize = await completer.future;
  //    setState(() {
  //      _imageSize = imageSize;
  //    });
  //  }

  //  Future<void> scanImage(File imageFile) async {
  //    setState(() {
  //      _scanResults = null;
  //    });

  //   Future<void> getAndScanImage() async {
  //    setState(() {
  //     _imageFile = path as File;
  //     _imageSize = path as Size;
  //  });

  //    final File imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
  //   if (imageFile != null) {
  //      getImageSize(imageFile);
  //      scanImage(imageFile);
  //    }

  //    setState(() {
  //      _imageFile = imageFile;
  //    });
  //  }


  //    final FirebaseVisionImage visionImage =
  //        FirebaseVisionImage.fromFile(imageFile);
    
  //    dynamic results;
  //    switch (_currentDetector) {
  //       case Detector.label:
  //        final ImageLabeler labeler = FirebaseVision.instance.imageLabeler();
  //        results = await labeler.processImage(visionImage);
  //        break;
  //      case Detector.cloudLabel:
  //        final ImageLabeler labeler =
  //            FirebaseVision.instance.cloudImageLabeler();
  //        results = await labeler.processImage(visionImage);
  //        break;
  //      default:
  //        return;
  //  }

  //  setState(() {
  //      _scanResults = results;
  //    });
  //  }

  //  CustomPaint buildResults(Size imageSize, dynamic results) {
  //    CustomPainter painter;

  //    switch (_currentDetector) {
  //       case Detector.label:
  //          painter = LabelDetectorPainter(_imageSize, results);
  //          break;
  //        case Detector.cloudLabel:
  //          painter = LabelDetectorPainter(_imageSize, results);
  //          break;
  //        default:
  //          break;
  //    }
  //    return CustomPaint(
  //      painter: painter,
  //    );
  //  }

  // }

}

// class DisplayScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: <Widget>[
//           PopupMenuButton<Detector>(
//             onSelected: (Detector result) {
//               currentDetector = result;
//               if (imageFile != null) {
//                 scanImage(imageFile);
//               }
//             },
//             itemBuilder: (BuildContext context) => <PopupMenuEntry<Detector>> [
//               const PopupMenuItem<Detector>(
//                 child: Text("Detect Cloud Label"),
//                 value: Detector.cloudLabel,
//               ),
//               const PopupMenuItem<Detector>(
//                 child: Text("Detect Label"),
//                 value: Detector.label,
//               ),
//             ],
//           )
//         ],
//       ),
//       body: Column(
//         children: <Widget>[
//           _imageFile == null 
//           ? const Center(child: Text("No picture"))
//           : _buildImage(),
//         ],
//       ),
//     );
//   }

  
// }




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
                            print ("pressed");
                            // update food and go back to dashboard,
                          } 
                      ),
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

// class DisplayScreenState extends State<DisplayPictureScreen> {
//   final String imagePath;

//   DisplayScreenState({
//     Key key,
//     @required this.imagePath,
//   });
  
//   File _imageFile;
//   Size _imageSize;
//   dynamic _scanResults;
//   Detector _currentDetector = Detector.label;

//   // Future<void> _getAndScanImage() async {
//   //    setState(() {
//   //     _imageFile = imagePath as File;
//   //     _imageSize = imagePath as Size;
//   //  });

//   //    final File imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
//   //   if (imageFile != null) {
//   //      _getImageSize(imageFile);
//   //      _scanImage(imageFile);
//   //    }

//   //    setState(() {
//   //      _imageFile = imageFile;
//   //    });
//   //  }

//   //  Future<void> _getImageSize(File imageFile) async {
//   //    final Completer<Size> completer = Completer<Size>();

//   //    final Image image = Image.file(imageFile);
//   //    image.image.resolve(const ImageConfiguration()).addListener(
//   //      (ImageInfo info, bool _) {
//   //        completer.complete(Size(
//   //          info.image.width.toDouble(),
//   //          info.image.height.toDouble(),
//   //        ));
//   //      },
//   //    );
//   //    final Size imageSize = await completer.future;
//   //    setState(() {
//   //      _imageSize = imageSize;
//   //    });
//   //  }

//   //  Future<void> _scanImage(File imageFile) async {
//   //    setState(() {
//   //      _scanResults = null;
//   //    });

//   //    final FirebaseVisionImage visionImage =
//   //        FirebaseVisionImage.fromFile(imageFile);
    
//   //    dynamic results;
//   //    switch (_currentDetector) {
//   //       case Detector.label:
//   //        final ImageLabeler labeler = FirebaseVision.instance.imageLabeler();
//   //        results = await labeler.processImage(visionImage);
//   //        break;
//   //      case Detector.cloudLabel:
//   //        final ImageLabeler labeler =
//   //            FirebaseVision.instance.cloudImageLabeler();
//   //        results = await labeler.processImage(visionImage);
//   //        break;
//   //      default:
//   //        return;
//   //  }

//   //  setState(() {
//   //      _scanResults = results;
//   //    });
//   //  }

//   //  CustomPaint _buildResults(Size imageSize, dynamic results) {
//   //    CustomPainter painter;

//   //    switch (_currentDetector) {
//   //       case Detector.label:
//   //          painter = LabelDetectorPainter(_imageSize, results);
//   //          break;
//   //        case Detector.cloudLabel:
//   //          painter = LabelDetectorPainter(_imageSize, results);
//   //          break;
//   //        default:
//   //          break;
//   //    }
//   //    return CustomPaint(
//   //      painter: painter,
//   //    );
//   //  }

//    Widget _buildImage() {
//      return  Container(
//        constraints: const BoxConstraints.expand(),
//        decoration: BoxDecoration(
//          image: DecorationImage(
//            image: Image.file(_imageFile).image,
//            fit: BoxFit.fill,
//          ),
//        ),
//        child: _imageSize == null || _scanResults == null
//            ? const Center(
//                child: Text(
//                  'Scanning...',
//                  style: TextStyle(
//                    color: Colors.green,
//                    fontSize: 30.0,
//                  ),
//                ),
//              )
//            : buildResults(_imageSize, _scanResults),
//      );
//    }
  
//   @override
//   Widget build(BuildContext context) {
//    // print("$imagePath");

//     return Scaffold(
//       appBar: AppBar(
//         actions: <Widget>[
//           PopupMenuButton<Detector>(
//             onSelected: (Detector result) {
//               _currentDetector = result;
//               if (_imageFile != null) {
//                 scanImage(_imageFile);
//               }
//             },
//             itemBuilder: (BuildContext context) => <PopupMenuEntry<Detector>> [
//               const PopupMenuItem<Detector>(
//                 child: Text("Detect Cloud Label"),
//                 value: Detector.cloudLabel,
//               ),
//               const PopupMenuItem<Detector>(
//                 child: Text("Detect Label"),
//                 value: Detector.label,
//               ),
//             ],
//           )
//         ],
//       ),
//       body: Column(
//         children: <Widget>[
//           _imageFile == null 
//           ? const Center(child: Text("No picture"))
//           : _buildImage(),
//         ],
//       ),
//     );
//   }

// }