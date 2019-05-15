import 'package:calorie_count/main.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraPage extends StatefulWidget {
  List<CameraDescription> cameras;
  CameraPage(this.cameras);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CameraPageState();
  }
}

class CameraPageState extends State<CameraPage> {
  CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = new CameraController(widget.cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      } 
      setState(() {});
    });
  }

  @override
  void dispose()async {
    await controller?.dispose();
    super.dispose();
  }

  // @override
  // void dispose() {
  //   controller?.dispose();
  //   super.dispose();
  // }

@override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return 
        AspectRatio( 
        aspectRatio: controller.value.aspectRatio,
        child: new CameraPreview(controller),
        );

  }
}