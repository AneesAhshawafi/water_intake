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
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: GetBottomTitlesWidget,
            ),
          ),
        ),
        barGroups: barData.barData
            .map(
              (data) => BarChartGroupData(
                x: data.x,
                barRods: [
                  BarChartRodData(
                    toY: data.y,
                    color: Colors.lightGreen[700],
                    width: 20,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6),
                    ),
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: maxY,
                      color: Colors.grey[300],
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  Widget GetBottomTitlesWidget(double value, TitleMeta meta) {
    const TextStyle style = TextStyle(
      color: Color.fromARGB(255, 24, 23, 23),
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text('Su', style: style);
        break;
      case 1:
        text = Text('Mo', style: style);
        break;
      case 2:
        text = Text('Tu', style: style);
        break;
      case 3:
        text = Text('We', style: style);
        break;
      case 4:
        text = Text('Th', style: style);
        break;
      case 5:
        text = Text('Fr', style: style);
        break;
      case 6:
        text = Text('Sa', style: style);
        break;
      default:
        text = Text('');
        break;
    }
    return SideTitleWidget(meta: meta, space: 3, child: text);
  }
}
