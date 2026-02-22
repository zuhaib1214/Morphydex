class ScanDetails {
  final String scanId;
  final String imageUrl;
  final String diagnosePercentage;
  final String diagnosedLabel;
  final String time;
  final String day;
  final String date;
  final String uid;
  final String? suggestions;

  ScanDetails({
    required this.time,
    required this.day,
    required this.date,
    required this.scanId,
    required this.imageUrl,
    required this.diagnosePercentage,
    required this.uid,
    this.suggestions,
    required this.diagnosedLabel,
  });

  Map<String, dynamic> toMap() {
    return {
      'scanId': scanId,
      'imageUrl': imageUrl,
      'diagnosePercentage': diagnosePercentage,
      'date': date,
      'time': time,
      'day': day,
      'uid': uid,
      'suggestions': suggestions,
      'diagnosedLabel': diagnosedLabel,
    };
  }

  static ScanDetails fromMap(Map<String, dynamic> map) {
    return ScanDetails(
      scanId: map['scanId'] ?? "",
      suggestions: map['suggestions'] ?? "",
      imageUrl: map['imageUrl'] ?? "",
      diagnosePercentage: map['diagnosePercentage'] ?? "",
      diagnosedLabel: map['diagnosedLabel'] ?? "",
      uid: map['uid'] ?? "",
      time: map['time'] ?? "",
      day: map['day'] ?? "",
      date: map['date'] ?? "",
    );
  }
}
