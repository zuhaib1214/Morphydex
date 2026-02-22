import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:morphydex/data/network/firebase/auth_services.dart';
import 'package:morphydex/models/scan_model.dart';
import 'package:morphydex/data/network/firebase/firebase_services.dart';
import 'package:morphydex/res/constants.dart';
import 'package:morphydex/utils/utils.dart';
import 'package:morphydex/view/home/home_screen.dart';
import 'package:morphydex/view/widgets/buttons.dart';

class ScanDetailPage extends StatefulWidget {
  final File imageFile;
  final String percentageDiagnose;
  final String diagnosedLabel;
  const ScanDetailPage({
    Key? key,
    required this.imageFile,
    required this.percentageDiagnose,
    required this.diagnosedLabel,
  }) : super(key: key);

  @override
  State<ScanDetailPage> createState() => _ScanDetailPageState();
}

class _ScanDetailPageState extends State<ScanDetailPage> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    log(widget.percentageDiagnose);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.file(
                  widget.imageFile,
                  height: 200,
                  width: 200,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Diagnose Label: ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.diagnosedLabel, // Replace with actual diagnosis label
                style: const TextStyle(fontSize: 18),
              ),
              const Text(
                'Diagnose Percentage: ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "${widget.percentageDiagnose}%", // Replace with actual diagnosis percentage
                style: const TextStyle(fontSize: 18),
              ),
              Center(
                child: BGRoundButton(
                  text: "Save",
                  loading: loading,
                  onPressed: () async {
                    try {
                      loading = true;
                      setState(() {});
                      final imageUrl = await FirebaseStorageService()
                          .uploadImage(widget.imageFile,
                              DateTime.now().millisecondsSinceEpoch.toString());
                      final now = DateTime.now();
                      final date = DateFormat('yyyy-MM-dd').format(now);
                      final day = DateFormat('EEEE')
                          .format(now); // Format day as Monday, Tuesday, etc.
                      final time = DateFormat('HH:mm:ss').format(now);
                      final scanDetails = ScanDetails(
                          diagnosedLabel: widget.diagnosedLabel,
                          suggestions:
                              Constants.getSuggestions(widget.diagnosedLabel),
                          date: date,
                          day: day,
                          time: time,
                          scanId:
                              DateTime.now().millisecondsSinceEpoch.toString(),
                          imageUrl: imageUrl!,
                          diagnosePercentage: widget.percentageDiagnose,
                          uid: FirebaseAuthService.getCurrentUserID());
                      await FirebaseFirestoreService()
                          .saveScanDetails(scanDetails);
                      loading = false;
                      setState(() {});
                      Get.offAll(() => const HomeScreen());
                      Utils.showSnackBar(
                          'Success',
                          'Successfully Saved data',
                          const Icon(
                            Icons.warning_amber,
                            color: Colors.white,
                          ));
                      log("Done");
                    } catch (_) {
                      loading = false;
                      setState(() {});
                      Utils.showSnackBar(
                          'Warning',
                          _.toString(),
                          const Icon(
                            Icons.warning_amber,
                            color: Colors.white,
                          ));
                    }
                  },
                ),
              ),
              const Text(
                'Recommendations: ', // Replace with actual recommendations
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '${Constants.getSuggestions(widget.diagnosedLabel)} \nConsult a specialist for further evaluation.', // Replace with actual recommendations
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
