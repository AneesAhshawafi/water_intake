class WaterModel {
  final String? id;
  final String? unit;
  final double? amount;
  final DateTime dateTime;

  WaterModel({
    this.id,
    required this.amount,
    required this.dateTime,
    required this.unit,
  });

  factory WaterModel.fromJson(Map<String, dynamic> json, String id) {
    return WaterModel(
      id: id,
      amount: json['amount'] ?? 0.0,
      unit: json['unit'],
      dateTime: DateTime.parse(json['dateTime']),
    );
  }

  // convert the water model to json for sending to database
  Map<String, dynamic> toJson() {
    return {'amount': amount, 'unit': 'ml', 'dateTime': DateTime.now()};
  }
}
