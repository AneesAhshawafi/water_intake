import 'package:water_intake/widgets/indivisual_bar.dart';

class BarData {
  final double satWaterAmount;
  final double sunWaterAmount;
  final double monWaterAmount;
  final double tueWaterAmount;
  final double wenWaterAmount;
  final double thuWaterAmount;
  final double friWaterAmount;

  BarData({
    required this.satWaterAmount,
    required this.sunWaterAmount,
    required this.monWaterAmount,
    required this.tueWaterAmount,
    required this.wenWaterAmount,
    required this.thuWaterAmount,
    required this.friWaterAmount,
  });

  List<IndivisualBar> barData = [];

  // initailaize the bar data
  void initBarDate() {
    barData = [
      IndivisualBar(x: 0, y: satWaterAmount),
      IndivisualBar(x: 0, y: sunWaterAmount),
      IndivisualBar(x: 0, y: monWaterAmount),
      IndivisualBar(x: 0, y: tueWaterAmount),
      IndivisualBar(x: 0, y: wenWaterAmount),
      IndivisualBar(x: 0, y: thuWaterAmount),
      IndivisualBar(x: 0, y: friWaterAmount),
    ];
  }
}
