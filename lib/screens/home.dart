import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_intake/data/water_provider.dart';
import 'package:water_intake/models/water_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController amountControler = TextEditingController();
  @override
  void initState() {
    super.initState();
    // Fetch data once when widget loads
    Future.microtask(() => context.read<WaterProvider>().getWater());
  }

  void saveWater() async {
    // Provider.of<WaterProvider>(context,listen: false);
    final waterProvider = context.read<WaterProvider>();
    WaterModel waterModel = WaterModel(
      amount: double.parse(amountControler.text.toString()),
      dateTime: DateTime.now(),
      unit: 'ml',
    );
    waterProvider.addWater(waterModel);
    if (!context.mounted) {
      return; //if the widget not mounted do not do anything
    }
  }

  // Future<List<WaterModel>> getWater() async {
  //   return await context.read<WaterProvider>().getWater();
  // }

  void addWater() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Water"),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Add water to your daily intake",
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 3),
              TextField(
                controller: amountControler,
                keyboardType: TextInputType.number,
                maxLines: 1,
                decoration: InputDecoration(
                  hint: Text('Amount...'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(width: 1),
                  ),
                ),
              ),
              // SizedBox(height: 15),
              // SizedBox(
              //   width: double.infinity,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     children: [],
              //   ),
              // ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                saveWater();
                Navigator.of(context).pop();
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WaterProvider>(
      builder: (context, provider, child) => Scaffold(
        appBar: AppBar(
          title: const Text(
            "Water Intake",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: addWater,
          child: const Icon(Icons.add),
        ),
        body: provider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : provider.waterDataList.isEmpty
            ? const Center(child: Text("No water intake records yet."))
            : ListView.builder(
                itemCount: provider.waterDataList.length,
                itemBuilder: (context, index) {
                  final waterData = provider.waterDataList[index];
                  return ListTile(
                    leading: const CircleAvatar(child: Text("W")),
                    title: Text("${waterData.amount} ${waterData.unit}"),
                    subtitle: Text(waterData.dateTime.toLocal().toString()),
                  );
                },
              ),
      ),
    );
  }
}
