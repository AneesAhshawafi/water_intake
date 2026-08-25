import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_intake/data/water_provider.dart';
import 'package:water_intake/models/water_model.dart';

class WaterTile extends StatelessWidget {
  final WaterModel waterData;
  const WaterTile({super.key, required this.waterData});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        // leading: const CircleAvatar(child: Text("W")),
        title: Row(
          children: [
            Icon(Icons.water_drop, size: 20, color: Colors.blueAccent),
            Text(
              "${waterData.amount!.toStringAsFixed(2)} ${waterData.unit}",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(left: 3),
          child: Text(
            '${waterData.dateTime.day.toString()}/${waterData.dateTime.month.toString()}/${waterData.dateTime.year.toString()}',
          ),
        ),
        trailing: IconButton(onPressed: () {
          context.read<WaterProvider>().delete(waterData);
        }, icon: Icon(Icons.delete)),
      ),
    );
  }
}
