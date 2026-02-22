import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morphydex/models/scan_model.dart';
import 'package:morphydex/view/home/scan_details/scan_details.dart';

class ScanListPage extends StatelessWidget {
  final String day;
  final String date;
  // final int frequency;
  final List<ScanDetails> scanDetailsList;
  const ScanListPage(
      {super.key,
      required this.day,
      required this.date,
      required this.scanDetailsList});

  @override
  Widget build(BuildContext context) {
    List<ScanDetails> filteredScanList = scanDetailsList
        .where((scan) => scan.day == day && scan.date == date)
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Scans for $day, $date'),
      ),
      body: ListView.builder(
        itemCount: filteredScanList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.to(() => ScanDetailsPage(scanData: filteredScanList[index]));
            },
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(filteredScanList[index].imageUrl),
              ),
              title: Text(filteredScanList[index].date),
              subtitle: Text(filteredScanList[index].diagnosePercentage),
            ),
          );
        },
      ),
    );
  }
}
