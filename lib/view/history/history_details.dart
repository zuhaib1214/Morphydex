import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:morphydex/models/scan_model.dart';

class HistoryDetailPage extends StatelessWidget {
  final ScanDetails scanData;

  const HistoryDetailPage({Key? key, required this.scanData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History Detail'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CachedNetworkImage(
            imageUrl: scanData.imageUrl,
            height: 200,
            width: 200,
          ),
          const SizedBox(height: 16),
          Text(
            'Diagnose Percentage: ${scanData.diagnosePercentage}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(
            'Recommendations: ${scanData.suggestions}',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
