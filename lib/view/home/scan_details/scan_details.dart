import 'package:flutter/material.dart';
import 'package:morphydex/models/scan_model.dart';

class ScanDetailsPage extends StatelessWidget {
  final ScanDetails scanData;

  const ScanDetailsPage({
    Key? key,
    required this.scanData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            scanData.imageUrl,
            height: 200,
            width: 200,
          ),
          const SizedBox(height: 16),
          // Text(scanData.date,
          //     style:
          //         const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('Date: ${scanData.date}', style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
          Text('Day: ${scanData.day}', style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
          Text('Prediction: ${scanData.diagnosePercentage}',
              style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
          Text('Suggestions: ${scanData.suggestions ?? "N/A"}',
              style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
