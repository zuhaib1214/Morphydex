// import 'dart:developer';
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:image/image.dart' as img;
// import 'package:image_picker/image_picker.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';

// class ModelInferencePage extends StatefulWidget {
//   const ModelInferencePage({Key? key}) : super(key: key);

//   @override
//   _ModelInferencePageState createState() => _ModelInferencePageState();
// }

// class _ModelInferencePageState extends State<ModelInferencePage> {
//   File? _imageFile;
//   Interpreter? _interpreter;
//   Map<String, dynamic>? _predictionDetails;

//   @override
//   void initState() {
//     super.initState();
//     // Load the model interpreter when the widget initializes
//     loadModel();
//   }

//   @override
//   void dispose() {
//     // Dispose the model interpreter when the widget is disposed
//     _interpreter?.close();
//     super.dispose();
//   }

//   // Load the TensorFlow Lite model interpreter
//   Future<void> loadModel() async {
//     final interpreterOptions = InterpreterOptions();
//     // Add any interpreter options if needed

//     // Load the model from assets
//     _interpreter = await Interpreter.fromAsset(
//       'assets/model/tf_lite_morphydexModel.tflite',
//       options: interpreterOptions,
//     );
//   }

//   // Perform inference on the loaded model with the provided image
//   Future<void> performInference(File imageFile) async {
//     if (_interpreter == null) return;

//     // Read the image file and convert it to an image
//     final image = img.decodeImage(await imageFile.readAsBytes());

//     // Preprocess the image and convert it to a NumPy array
//     final preprocessedImage = preprocessImage(image!);

//     // Run inference on the model
//     final outputResults = Float32List(3); // Assuming 3 output classes
//     final outputBuffer =
//         Float32List(3 * 1); // Create output buffer with correct shape [3, 1]

//     // Reshape the output buffer to match the expected shape [1, 3]
//     final reshapedOutputBuffer = outputBuffer.reshape([1, 3]);

//     _interpreter!
//         .run(preprocessedImage.buffer.asUint8List(), reshapedOutputBuffer);

//     // Find the index with the highest probability
//     int maxIndex = 0;
//     double maxProbability = 0.0;
//     for (int i = 0; i < 3; i++) {
//       if (reshapedOutputBuffer[0][i] > maxProbability) {
//         maxIndex = i;
//         maxProbability = reshapedOutputBuffer[0][i];
//       }
//     }

//     // Map index to label
//     String predictionLabel = '';
//     switch (maxIndex) {
//       case 0:
//         predictionLabel = 'Basal Cell Carcinoma (Cancer)';
//         break;
//       case 1:
//         predictionLabel = 'Nevus (Non-Cancerous)';
//         break;
//       case 2:
//         predictionLabel = 'Melanoma (Cancer)';
//         break;
//     }

//     setState(() {
//       _predictionDetails = {
//         'predictionPercentage': (maxProbability * 100).toStringAsFixed(2),
//         'predictionLabel': predictionLabel,
//       };
//     });
//   }

//   // Preprocess the image: resize to 224x224 and normalize pixel values
//   Uint8List preprocessImage(img.Image image) {
//     final resizedImage = img.copyResize(image, width: 224, height: 224);
//     final inputArray = Float32List(224 * 224 * 3);

//     for (int y = 0; y < 224; y++) {
//       for (int x = 0; x < 224; x++) {
//         final pixelIndex = (y * 224 + x) * 3;
//         final pixel = resizedImage.getPixel(x, y);
//         inputArray[pixelIndex] = pixel.r / 255.0;
//         inputArray[pixelIndex + 1] = pixel.g / 255.0;
//         inputArray[pixelIndex + 2] = pixel.b / 255.0;
//       }
//     }

//     return inputArray.buffer.asUint8List();
//   }

//   // Display the image picker and perform inference when an image is selected
//   Future<void> _getImageAndPredict() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = File(pickedFile.path);
//         _predictionDetails = null; // Clear previous prediction details
//       });

//       // Perform inference with the selected image
//       await performInference(_imageFile!);
//       log('Performed inference'); // Log that inference was performed
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Model Inference')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             _imageFile == null
//                 ? const Text('No image selected.')
//                 : Image.file(_imageFile!),
//             if (_predictionDetails != null)
//               Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Column(
//                   children: [
//                     Text(
//                       'Prediction: ${_predictionDetails!['predictionLabel']}',
//                       style: const TextStyle(fontSize: 20),
//                     ),
//                     Text(
//                       'Confidence: ${_predictionDetails!['predictionPercentage']}%',
//                       style: const TextStyle(fontSize: 20),
//                     ),
//                   ],
//                 ),
//               ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _getImageAndPredict,
//         tooltip: 'Pick Image',
//         child: const Icon(Icons.image),
//       ),
//     );
//   }
// }
