import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double _containerPosition = 0.0;

  void _moveContainer() {
    setState(() {
      _containerPosition = _containerPosition == 0.0 ? 20.0 : 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.blueGrey,
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const FlutterSide(),
                const SizedBox(height: 10.0),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  margin: EdgeInsets.only(left: _containerPosition),
                  color: Colors.blue,
                  width: 100,
                  height: 100,
                  child: const KotlinSide(),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _moveContainer,
                  child: const Text('Toggle Container'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FlutterSide extends StatelessWidget {
  const FlutterSide({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: 120.0,
      color: Colors.deepOrange,
      child: const Text(
        "Flutter texto",
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
    );
  }
}

class KotlinSide extends StatelessWidget {
  const KotlinSide({super.key});

  @override
  Widget build(BuildContext context) {
    // This is used in the platform side to register the view.
    const String viewType = '<platform-view-type>';
    // Pass parameters to the platform side.
    const Map<String, dynamic> creationParams = <String, dynamic>{};

    return Container(
      height: 50.0,
      width: 120.0,
      color: Colors.greenAccent,
      alignment: Alignment.center,
      child: PlatformViewLink(
        viewType: viewType,
        surfaceFactory: (context, controller) {
          return AndroidViewSurface(
            controller: controller as AndroidViewController,
            gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
            hitTestBehavior: PlatformViewHitTestBehavior.opaque,
          );
        },
        onCreatePlatformView: (params) {
          return PlatformViewsService.initSurfaceAndroidView(
            id: params.id,
            viewType: viewType,
            layoutDirection: TextDirection.ltr,
            creationParams: creationParams,
            creationParamsCodec: const StandardMessageCodec(),
            onFocus: () {
              params.onFocusChanged(true);
            },
          )
            ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
            ..create();
        },
      ),
    );
  }
}
