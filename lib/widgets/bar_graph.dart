import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:water_intake/widgets/bar_data.dart';

class BarGraph extends StatelessWidget {
  final double maxY;
  final double satWaterAmount;
  final double sunWaterAmount;
  final double monWaterAmount;
  final double tueWaterAmount;
  final double wenWaterAmount;
  final double thuWaterAmount;
  final double friWaterAmount;

  const BarGraph({
    super.key,
    required this.maxY,
    required this.satWaterAmount,
    required this.sunWaterAmount,
    required this.monWaterAmount,
    required this.tueWaterAmount,
    required this.wenWaterAmount,
    required this.thuWaterAmount,
    required this.friWaterAmount,
  });

  @override
  Widget build(BuildContext context) {
    BarData barData = BarData(
      satWaterAmount: satWaterAmount,
      sunWaterAmount: sunWaterAmount,
      monWaterAmount: monWaterAmount,
      tueWaterAmount: tueWaterAmount,
      wenWaterAmount: wenWaterAmount,
      thuWaterAmount: thuWaterAmount,
      friWaterAmount: friWaterAmount,
    );
    barData.initBarData();
    return BarChart(
      BarChartData(
        maxY: maxY,
        minY: 0,
        barGroups: barData.barData
            .map(
              (data) => BarChartGroupData(
                x: data.x,
                barRods: [BarChartRodData(toY: data.y)],
              ),
            )
            .toList(),
      ),
    );
  }
}
