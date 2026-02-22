// import 'dart:developer';
// import 'dart:io';
// import 'dart:isolate';
// import 'package:camera/camera.dart';
// import 'package:image/image.dart' as image_lib;
// import 'package:tflite_flutter/tflite_flutter.dart';

// class IsolateInference {
//   static const String _debugName = "TFLITE_INFERENCE";
//   final ReceivePort _receivePort = ReceivePort();
//   late Isolate _isolate;
//   late SendPort _sendPort;

//   SendPort get sendPort => _sendPort;

//   Future<void> start() async {
//     _isolate = await Isolate.spawn<SendPort>(entryPoint, _receivePort.sendPort,
//         debugName: _debugName);
//     _sendPort = await _receivePort.first;
//   }

//   Future<void> close() async {
//     _isolate.kill();
//     _receivePort.close();
//   }

//   static void entryPoint(SendPort sendPort) async {
//     final port = ReceivePort();
//     sendPort.send(port.sendPort);

//     await for (final InferenceModel isolateModel in port) {
//       image_lib.Image? img;
//       // if (isolateModel.isCameraFrame()) {
//       //   img = ImageUtils.convertCameraImage(isolateModel.cameraImage!);
//       // } else {
//       img = isolateModel.image;
//       // }

//       // resize original image to match model shape.
//       image_lib.Image imageInput = image_lib.copyResize(
//         img!,
//         width: isolateModel.inputShape[1],
//         height: isolateModel.inputShape[2],
//       );

//       log("input width ${isolateModel.inputShape[1]}");
//       log("input height ${isolateModel.inputShape[2]}");
//       log("input hhh ${isolateModel.inputShape}");
//       if (Platform.isAndroid && isolateModel.isCameraFrame()) {
//         imageInput = image_lib.copyRotate(imageInput, angle: 90);
//       }

//       final imageMatrix = List.generate(
//         imageInput.height,
//         (y) => List.generate(
//           imageInput.width,
//           (x) {
//             final pixel = imageInput.getPixel(x, y);
//             return [pixel.r, pixel.g, pixel.b];
//           },
//         ),
//       );

//       // Set tensor input [1, 224, 224, 3]
//       final input = [imageMatrix];
//       // log("input shape $input");

//       final output = [List<double>.filled(isolateModel.outputShape[1], 0)];
//       // // Run inference
//       log("output shape 1. ${isolateModel.outputShape[1]}");
//       log("output shape ${isolateModel.outputShape}");
//       Interpreter interpreter =
//           Interpreter.fromAddress(isolateModel.interpreterAddress);
//       interpreter.run(input, output);
//       // Get first output tensor

//       log("output $output");
//       final result = output.first;
//       log("result $result");
//       // Calculate max score
//       final maxScore = result.reduce((max, value) => value > max ? value : max);
//       log("max score $maxScore");
//       // Set classification map {label: points}
//       final classification = <String, double>{};
//       for (var i = 0; i < result.length; i++) {
//         if (result[i] != 0) {
//           // Set label: points
//           classification[isolateModel.labels[i]] = result[i] / maxScore;
//         }
//       }
//       isolateModel.responsePort.send(classification);
//     }
//   }
// }

// class InferenceModel {
//   CameraImage? cameraImage;
//   image_lib.Image? image;
//   int interpreterAddress;
//   List<String> labels;
//   List<int> inputShape;
//   List<int> outputShape;
//   late SendPort responsePort;

//   InferenceModel(this.cameraImage, this.image, this.interpreterAddress,
//       this.labels, this.inputShape, this.outputShape);

//   // check if it is camera frame or still image
//   bool isCameraFrame() {
//     return cameraImage != null;
//   }
// }
