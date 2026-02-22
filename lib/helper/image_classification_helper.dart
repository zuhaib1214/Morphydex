// import 'dart:developer';
// import 'dart:io';
// import 'dart:isolate';

// import 'package:camera/camera.dart';
// import 'package:flutter/services.dart';
// import 'package:image/image.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';

// import 'isolate_inference.dart';

// class ImageClassificationHelper {
//   static const modelPath = 'assets/model/tf_lite_morphydexModel.tflite';
//   static const labelsPath = 'assets/model/Labels.txt';

//   late final Interpreter interpreter;
//   late final List<String> labels;
//   late final IsolateInference isolateInference;
//   late Tensor inputTensor;
//   late Tensor outputTensor;

//   // Load model
//   Future<void> _loadModel() async {
//     final options = InterpreterOptions();

//     // Use XNNPACK Delegate
//     if (Platform.isAndroid) {
//       options.addDelegate(XNNPackDelegate());
//     }

//     // Use GPU Delegate
//     // doesn't work on emulator
//     // if (Platform.isAndroid) {
//     //   options.addDelegate(GpuDelegateV2());
//     // }

//     // Load model from assets
//     interpreter = await Interpreter.fromAsset(modelPath, options: options);
//     inputTensor = interpreter.getInputTensors().first;
//     outputTensor = interpreter.getOutputTensors().first;
//     log("inputTensor $inputTensor");
//     log("outputTensor $outputTensor");
//     log("interpreter ${interpreter.isAllocated}");

//     log('Interpreter loaded successfully');
//   }

//   // Load labels from assets
//   Future<void> _loadLabels() async {
//     final labelTxt = await rootBundle.loadString(labelsPath);
//     labels = labelTxt.split('\n');
//   }

//   Future<void> initHelper() async {
//     _loadLabels();
//     _loadModel();
//     isolateInference = IsolateInference();
//     await isolateInference.start();
//   }

//   Future<Map<String, double>> _inference(InferenceModel inferenceModel) async {
//     ReceivePort responsePort = ReceivePort();
//     isolateInference.sendPort
//         .send(inferenceModel..responsePort = responsePort.sendPort);
//     // get inference result.
//     var results = await responsePort.first;
//     return results;
//   }

//   // inference camera frame
//   Future<Map<String, double>> inferenceCameraFrame(
//       CameraImage cameraImage) async {
//     var isolateModel = InferenceModel(cameraImage, null, interpreter.address,
//         labels, inputTensor.shape, outputTensor.shape);
//     return _inference(isolateModel);
//   }

//   // inference still image
//   Future<Map<String, double>> inferenceImage(Image image) async {
//     var isolateModel = InferenceModel(null, image, interpreter.address, labels,
//         inputTensor.shape, outputTensor.shape);
//     return _inference(isolateModel);
//   }

//   Future<void> close() async {
//     isolateInference.close();
//   }
// }
