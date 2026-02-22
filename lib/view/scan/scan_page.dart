import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:morphydex/view/scan/scan_controller.dart';
import 'package:morphydex/view/scan/scan_detail.dart';
import 'package:morphydex/view/widgets/buttons.dart';

class ScanPage extends StatelessWidget {
  ScanPage({Key? key}) : super(key: key);
  final controller = Get.put(ScanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Page'),
      ),
      body: GetBuilder<ScanController>(
        builder: (controller) => Center(
          child: controller.cameraIsAvailable
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (controller.imageFile != null) ...[
                      Image.file(
                        controller.imageFile!,
                        // File(controller.imagePath!),
                        height: 250,
                        width: 250,
                      ),
                      const SizedBox(height: 16),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            if (controller.predictionDetails != null)
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    // Column(
                                    //   crossAxisAlignment:
                                    //       CrossAxisAlignment.start,
                                    //   children: controller.imageLabels
                                    //       .map((label) => Text(label))
                                    //       .toList(),
                                    // ),
                                    // Column(
                                    //   crossAxisAlignment:
                                    //       CrossAxisAlignment.start,
                                    //   children: controller
                                    //           .imageLabels.isNotEmpty
                                    //       ? [Text(controller.imageLabels.first)]
                                    //       : [],
                                    // ),
                                    Text(
                                      controller.predictionDetails![
                                          'predictionLabel'],
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      'Confidence: ${controller.predictionDetails!['predictionPercentage']}%',
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                      BGRoundButton(
                        onPressed: () {
                          Get.to(
                            () => ScanDetailPage(
                              diagnosedLabel: controller
                                  .predictionDetails!['predictionLabel'],
                              percentageDiagnose: controller
                                  .predictionDetails!['predictionPercentage'],
                              imageFile: controller.imageFile!,
                            ),
                          );
                        },
                        text: 'View Details',
                      ),
                    ] else ...[
                      const Center(
                        child: Image(
                          image: AssetImage(
                            "assets/images/6.png",
                          ),
                          height: 200,
                          width: 250,
                        ),
                      ),
                      Center(
                        child: BGRoundButton(
                          onPressed: () => controller
                              .getImageAndPredict(ImageSource.gallery),
                          text: 'Pick Image from Gallery',
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: WhiteBGTextButton(
                            onPressed: () => controller
                                .getImageAndPredict(ImageSource.camera),
                            text: 'Take Photo'),
                      ),
                    ],
                  ],
                )
              : const Center(child: Text("Camera unavailable")),
        ),
      ),
    );
  }
}
