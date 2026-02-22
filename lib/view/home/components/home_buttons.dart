import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morphydex/view/history/history_screen.dart';
import 'package:morphydex/view/scan/scan_page.dart';
import 'package:morphydex/view/widgets/buttons.dart';

class HomeButtons extends StatelessWidget {
  const HomeButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        WhiteBGTextButton(
            onPressed: () {
              Get.to(() => ScanPage());
            },
            text: 'Scan'),
        BGRoundButton(
          onPressed: () {
            Get.to(() => const HistoryPage());
          },
          text: 'History',
        ),
      ],
    );
  }
}
