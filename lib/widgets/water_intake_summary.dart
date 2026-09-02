import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_intake/data/water_provider.dart';
import 'package:water_intake/widgets/bar_graph.dart';

class WaterIntakeSummary extends StatelessWidget {
  final DateTime startOfWeek;
  const WaterIntakeSummary({super.key, required this.startOfWeek});

  @override
  Widget build(BuildContext context) {
    return Consumer<WaterProvider>(
      builder: (context, value, child) {
        return SizedBox(
          height: 200,
          child: BarGraph(
            maxY: 100,
            satWaterAmount: 19,
            sunWaterAmount: 29,
            monWaterAmount: 15,
            tueWaterAmount: 50,
            wenWaterAmount: 59,
            thuWaterAmount: 40,
            friWaterAmount: 90,
          ),
        );
      },
    );
  }
}
