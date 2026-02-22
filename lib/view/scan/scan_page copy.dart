// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:morphydex/helper/image_classification_helper.dart';
// import 'package:morphydex/view/widgets/buttons.dart';
// import 'package:morphydex/view/scan/scan_detail.dart';
// import 'package:image/image.dart' as img;

// class ScanPage extends StatefulWidget {
//   const ScanPage({Key? key}) : super(key: key);

//   @override
//   _ScanPageState createState() => _ScanPageState();
// }

// class _ScanPageState extends State<ScanPage> {
//   // File? _pickedImage;
//   final ImagePicker _imagePicker = ImagePicker();

//   ImageClassificationHelper? imageClassificationHelper;
//   String? imagePath;
//   img.Image? image;
//   Map<String, double>? classification;
//   bool cameraIsAvailable = Platform.isAndroid || Platform.isIOS;
//   String percentage = '', name = '';
//   @override
//   void initState() {
//     imageClassificationHelper = ImageClassificationHelper();
//     imageClassificationHelper!.initHelper();
//     super.initState();
//   }

//   void cleanResult() {
//     imagePath = null;
//     image = null;
//     classification = null;
//     setState(() {});
//   }

//   Future<void> processImage() async {
//     if (imagePath != null) {
//       // Read image bytes from file
//       final imageData = File(imagePath!).readAsBytesSync();

//       // Decode image using package:image/image.dart (https://pub.dev/image)
//       image = img.decodeImage(imageData);
//       setState(() {});
//       classification = await imageClassificationHelper?.inferenceImage(image!);
//       setState(() {});
//     }
//   }

//   @override
//   void dispose() {
//     imageClassificationHelper?.close();
//     super.dispose();
//   }

//   Future<void> _pickImage(ImageSource source) async {
//     final result = await _imagePicker.pickImage(source: source);

//     if (result != null) {
//       imagePath = result.path;

//       setState(() {
//         processImage();
//       });
//       // setState(() {
//       //   _pickedImage = File(result.path);
//       // });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Scan Page'),
//       ),
//       body: Center(
//         child: cameraIsAvailable
//             ? Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   if (image != null) ...[
//                     // Show model information
//                     if (imageClassificationHelper?.inputTensor != null)
//                       Text(
//                         'Input: (shape: ${imageClassificationHelper?.inputTensor.shape} type: '
//                         '${imageClassificationHelper?.inputTensor.type})',
//                       ),
//                     if (imageClassificationHelper?.outputTensor != null)
//                       Text(
//                         'Output: (shape: ${imageClassificationHelper?.outputTensor.shape} '
//                         'type: ${imageClassificationHelper?.outputTensor.type})',
//                       ),
//                     const SizedBox(height: 8),
//                     // Show picked image information
//                     Text('Num channels: ${image?.numChannels}'),
//                     Text('Bits per channel: ${image?.bitsPerChannel}'),
//                     Text('Height: ${image?.height}'),
//                     Text('Width: ${image?.width}'),
//                   ],
//                   SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         if (classification != null)
//                           ...(classification!.entries.toList()
//                                 ..sort(
//                                   (a, b) => a.value.compareTo(b.value),
//                                 ))
//                               .reversed
//                               .take(1)
//                               .map(
//                             (e) {
//                               percentage = e.value.toStringAsFixed(2);
//                               return Container(
//                                 padding: const EdgeInsets.all(8),
//                                 color: Colors.white,
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceAround,
//                                   children: [
//                                     Text(e.key),
//                                     Text(e.value.toStringAsFixed(2))
//                                   ],
//                                 ),
//                               );
//                             },
//                           ),
//                       ],
//                     ),
//                   ),
//                   if (imagePath != null) ...[
//                     Image.file(
//                       File(imagePath!),
//                       height: 250,
//                       width: 250,
//                     ),
//                     const SizedBox(height: 16),
//                     BGRoundButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => ScanDetailPage(
//                               percentageDiagnose: percentage,
//                               imageFile: File(imagePath!),
//                             ),
//                           ),
//                         );
//                       },
//                       text: 'View Details',
//                     ),
//                   ] else ...[
//                     const Center(
//                       child: Image(
//                         image: AssetImage(
//                           "assets/images/6.png",
//                         ),
//                         height: 200,
//                         width: 250,
//                       ),
//                     ),
//                     Center(
//                       child: BGRoundButton(
//                         onPressed: () => _pickImage(ImageSource.gallery),
//                         text: 'Pick Image from Gallery',
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     Center(
//                       child: WhiteBGTextButton(
//                           onPressed: () => _pickImage(ImageSource.camera),
//                           text: 'Take Photo'),
//                     ),
//                   ],
//                 ],
//               )
//             : const Center(child: Text("Camera unavailable")),
//       ),
//     );
//   }
// }
