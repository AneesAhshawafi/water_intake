import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_intake/data/water_provider.dart';
import 'package:water_intake/utils/date_helper.dart';
import 'package:water_intake/widgets/bar_graph.dart';

class WaterIntakeSummary extends StatelessWidget {
  final DateTime startOfWeek;
  const WaterIntakeSummary({super.key, required this.startOfWeek});

  double calculateMaxAmount(
    WaterProvider waterProvider,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
  ) {
    double maxAmount = 100;
    List<double> values = [
      waterProvider.calculaterDailyWaterSummury()[sunday] ?? 0,
      waterProvider.calculaterDailyWaterSummury()[monday] ?? 0,
      waterProvider.calculaterDailyWaterSummury()[tuesday] ?? 0,
      waterProvider.calculaterDailyWaterSummury()[wednesday] ?? 0,
      waterProvider.calculaterDailyWaterSummury()[thursday] ?? 0,
      waterProvider.calculaterDailyWaterSummury()[friday] ?? 0,
      waterProvider.calculaterDailyWaterSummury()[saturday] ?? 0,
    ];
    // sort from smallest to largest
    values.sort();
    // get the largest value
    // icrease the max amount by x% of the largest value
    maxAmount = values.last * 1.3;
    return maxAmount == 0 ? 100 : maxAmount;
  }

  @override
  Widget build(BuildContext context) {
    String sunday = convertDateTimeToString(startOfWeek.add(Duration(days: 0)));
    String monday = convertDateTimeToString(startOfWeek.add(Duration(days: 1)));
    String tuesday = convertDateTimeToString(
      startOfWeek.add(Duration(days: 2)),
    );
    String wednesday = convertDateTimeToString(
      startOfWeek.add(Duration(days: 3)),
    );
    String thursday = convertDateTimeToString(
      startOfWeek.add(Duration(days: 4)),
    );
    String friday = convertDateTimeToString(startOfWeek.add(Duration(days: 5)));
    String saturday = convertDateTimeToString(
      startOfWeek.add(Duration(days: 6)),
    );
    return Consumer<WaterProvider>(
      builder: (context, value, child) {
        return SizedBox(
          height: 200,
          child: BarGraph(
            maxY: calculateMaxAmount(
              value,
              sunday,
              monday,
              tuesday,
              wednesday,
              thursday,
              friday,
              saturday,
            ),
            satWaterAmount: value.calculaterDailyWaterSummury()[sunday] ?? 0,
            sunWaterAmount: value.calculaterDailyWaterSummury()[monday] ?? 0,
            monWaterAmount: value.calculaterDailyWaterSummury()[tuesday] ?? 0,
            tueWaterAmount: value.calculaterDailyWaterSummury()[wednesday] ?? 0,
            wenWaterAmount: value.calculaterDailyWaterSummury()[thursday] ?? 0,
            thuWaterAmount: value.calculaterDailyWaterSummury()[friday] ?? 0,
            friWaterAmount: value.calculaterDailyWaterSummury()[saturday] ?? 0,
          ),
        );
      },
    );
  }
}
