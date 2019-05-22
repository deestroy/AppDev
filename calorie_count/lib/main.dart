import 'dart:async';
import 'dart:io';

import 'package:calorie_count/src/UI/calorieCalc.dart';
import 'package:calorie_count/src/UI/loginPage.dart';
import 'package:calorie_count/src/UI/rootPage.dart';
import 'package:calorie_count/src/UI/settingPage.dart';
import 'package:flutter/material.dart';
import './src/UI/questionPage.dart';
import './src/UI/dashboardPage.dart';
import './src/UI/cameraPage.dart';
import './src/UI/settingsPage.dart';
import './src/UI/progressPage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'utils.dart';
import 'auth.dart';
import './src/detector_painters.dart';
import 'package:flutter/foundation.dart';
import 'package:camera/camera.dart';

List<CameraDescription> cameras;

Future<void> main() async {
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => RootPage(),
        '/login': (context) => LogInPage(),
        '/home': (context) => HomePage(cameras),
        '/questionnaire': (context) => QuestionPage(),
        '/results': (context) => CalorieCalc(),
        '/dashboard': (context) => DashboardPage(),
        '/setting': (context) => SettingPage(),
      },
    );
  }//build
}

class HomePage extends StatefulWidget {
  var cameras;
  HomePage(this.cameras);

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  File _imageFile;
  Size _imageSize;
  dynamic _scanResults;
  Detector _currentDetector = Detector.label;

  Future<void> _getAndScanImage() async {
     setState(() {
      _imageFile = null;
      _imageSize = null;
   });
     final File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
     if (imageFile != null) {
       _getImageSize(imageFile);
       _scanImage(imageFile);
     }

     setState(() {
       _imageFile = imageFile;
     });
   }

   Future<void> _getImageSize(File imageFile) async {
     final Completer<Size> completer = Completer<Size>();

     final Image image = Image.file(imageFile);
     image.image.resolve(const ImageConfiguration()).addListener(
       (ImageInfo info, bool _) {
         completer.complete(Size(
           info.image.width.toDouble(),
           info.image.height.toDouble(),
         ));
       },
     );
     final Size imageSize = await completer.future;
     setState(() {
       _imageSize = imageSize;
     });
   }

   Future<void> _scanImage(File imageFile) async {
     setState(() {
       _scanResults = null;
     });

     final FirebaseVisionImage visionImage =
         FirebaseVisionImage.fromFile(imageFile);
    
     dynamic results;
     switch (_currentDetector) {
        case Detector.label:
         final ImageLabeler labeler = FirebaseVision.instance.imageLabeler();
         results = await labeler.processImage(visionImage);
         break;
       case Detector.cloudLabel:
         final ImageLabeler labeler =
             FirebaseVision.instance.cloudImageLabeler();
         results = await labeler.processImage(visionImage);
         break;
       default:
         return;
   }

   setState(() {
       _scanResults = results;
     });
   }
   CustomPaint _buildResults(Size imageSize, dynamic results) {
     CustomPainter painter;

     switch (_currentDetector) {
        case Detector.label:
           painter = LabelDetectorPainter(_imageSize, results);
           break;
         case Detector.cloudLabel:
           painter = LabelDetectorPainter(_imageSize, results);
           break;
         default:
           break;
     }
     return CustomPaint(
       painter: painter,
     );
   }

   Widget _buildImage() {
     return Container(
       constraints: const BoxConstraints.expand(),
       decoration: BoxDecoration(
         image: DecorationImage(
           image: Image.file(_imageFile).image,
           fit: BoxFit.fill,
         ),
       ),
       child: _imageSize == null || _scanResults == null
           ? const Center(
               child: Text(
                 'Scanning...',
                 style: TextStyle(
                   color: Colors.green,
                   fontSize: 30.0,
                 ),
               ),
             )
           : _buildResults(_imageSize, _scanResults),
     );
   }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: new Scaffold(
            body: PageView(
      children: <Widget>[
        DashboardPage(),
        CameraPage(widget.cameras),
        ProgressPage(),
         PopupMenuButton<Detector>(
           onSelected: (Detector result) {
            _currentDetector = result;
            if (_imageFile != null) _scanImage(_imageFile);
           },
           itemBuilder: (BuildContext context) => <PopupMenuEntry<Detector>>[
               const PopupMenuItem<Detector>(
                   child: Text('Detect Cloud Label'),
                   value: Detector.cloudLabel,
               ),
               const PopupMenuItem<Detector>(
                   child: Text('Detect Text'),
                   value: Detector.label,
             ),
           ],
         ),
      ],
    )));
  }
}


class AppColours {
  final offBlack = const Color(0xFF4C4B4B);
  final coral = const Color(0xFFEA7773);
}

