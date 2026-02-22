import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morphydex/main.dart';
import 'package:morphydex/models/scan_model.dart';
import 'package:morphydex/view/history/history_details.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History Page'),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("scans")
            .doc(localUser!.token.toString())
            .collection('history')
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Text("Error");
          }
          if (!snapshot.hasData) {
            return const Text("No Data");
          }
          final List<ScanDetails> historyData = snapshot.data!.docs
              .map((doc) => ScanDetails.fromMap(doc.data()))
              .toList();
          return ListView.builder(
            itemCount: historyData.length,
            itemBuilder: (context, index) {
              return Dismissible(
                confirmDismiss: (direction) async {
                  bool t = false;
                  await showGeneralDialog(
                    context: context,
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return AlertDialog(
                        title: const Text(
                          'Delete Item',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        content:
                            const Text('Are you sure to delete this record'),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              Get.back();
                              t = false;
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              t = true;
                              Get.back();
                              await FirebaseFirestore.instance
                                  .collection('scans')
                                  .doc(localUser!.token.toString())
                                  .collection('history')
                                  .doc(historyData[index].scanId)
                                  .delete();
                            },
                            child: const Text(
                              'Ok',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                  return t;
                },
                key: UniqueKey(),
                child: Card(
                  surfaceTintColor: Colors.white,
                  elevation: 3,
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(HistoryDetailPage(scanData: historyData[index]));
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: CachedNetworkImageProvider(
                            historyData[index].imageUrl),
                      ),
                      title: Text(historyData[index].day),
                      subtitle: Text(historyData[index].date),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
