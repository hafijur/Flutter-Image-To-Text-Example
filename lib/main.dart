import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () async {
            //Pick an image
            final picker = ImagePicker();

            final pickedFile =
                await picker.getImage(source: ImageSource.camera);

            //OCR implementation
            //TODO catch errors
            final FirebaseVisionImage visionImage =
                FirebaseVisionImage.fromFile(File(pickedFile.path));

            final TextRecognizer textRecognizer =
                FirebaseVision.instance.textRecognizer();

            final VisionText recognizedText =
                await textRecognizer.processImage(visionImage);

            //Text will be displayed in the debug console
            debugPrint(recognizedText.text);
          },
          child: const Text('Get OCR Text'),
        ),
      ),
    );
  }
}
