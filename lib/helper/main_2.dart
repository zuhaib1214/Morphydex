// /*
//  * Copyright 2023 The TensorFlow Authors. All Rights Reserved.
//  *
//  * Licensed under the Apache License, Version 2.0 (the "License");
//  * you may not use this file except in compliance with the License.
//  * You may obtain a copy of the License at
//  *
//  *             http://www.apache.org/licenses/LICENSE-2.0
//  *
//  * Unless required by applicable law or agreed to in writing, software
//  * distributed under the License is distributed on an "AS IS" BASIS,
//  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  * See the License for the specific language governing permissions and
//  * limitations under the License.
//  */

// import 'dart:io';

// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';

// import 'ui/camera.dart';
// import 'ui/gallery.dart';

// class BottomNavigationBarExample extends StatelessWidget {
//   BottomNavigationBarExample({super.key});

//   late CameraDescription cameraDescription;

//   bool cameraIsAvailable = Platform.isAndroid || Platform.isIOS;

//   initPages() async {
//     if (cameraIsAvailable) {
//       // get list available camera
//       cameraDescription = (await availableCameras()).first;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }
