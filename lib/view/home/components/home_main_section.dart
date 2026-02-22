import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morphydex/models/scan_model.dart';
import 'package:morphydex/res/app_color.dart';
import 'package:morphydex/view/home/home_controller.dart';
import 'package:morphydex/view/home/scan_list/scan_list_page.dart';

class HomeMainSection extends StatefulWidget {
  const HomeMainSection({
    super.key,
  });

  @override
  State<HomeMainSection> createState() => _HomeMainSectionState();
}

class _HomeMainSectionState extends State<HomeMainSection> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: LineChart(
        LineChartData(
          // Placeholder data for demonstration
          titlesData: const FlTitlesData(
              // leftTitles: SideTitles(showTitles: false),
              // bottomTitles: SideTitles(showTitles: false),
              ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: [
                const FlSpot(0, 3),
                const FlSpot(1, 4),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HomeMainSection1 extends StatelessWidget {
  HomeMainSection1({super.key});
  final controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (ScanDetails data in controller.scanDetailsList)
              BuildDay(
                day: data.day,
                date: data.date,
                scanDetailsList: const [],
              ),
          ],
        ),
      ),
    );
  }
}

class BuildDay extends StatelessWidget {
  const BuildDay(
      {super.key,
      required this.day,
      required this.date,
      required this.scanDetailsList});
  final String day;
  final String date;
  final List<ScanDetails> scanDetailsList;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the ScanListPage for the selected day
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScanListPage(
              day: day,
              date: date,
              scanDetailsList: scanDetailsList,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Text(day,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Container(
              width: 30,
              height: 150,
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 30,
                height: scanDetailsList.length * 20.0,
                color: skinColor,
                child: Center(
                  child: Text(
                    scanDetailsList.length.toString(),
                    style: const TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              ),
            ),
            Text(date, style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
