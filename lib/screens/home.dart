import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_intake/data/water_provider.dart';
import 'package:water_intake/models/water_model.dart';
import 'package:water_intake/screens/about_screen.dart';
import 'package:water_intake/screens/settings_screen.dart';
import 'package:water_intake/widgets/water_intake_summary.dart';
import 'package:water_intake/widgets/water_tile.dart';

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
    clearWaterTextController();
  }

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
          elevation: 4,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Weekly: ',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  // fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                '${provider.calculateWeeklyWaterIntake(provider)} ml',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: addWater,
          child: const Icon(Icons.add),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Text(
                  'Water Intake',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              ListTile(
                title: Text('Settings'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SettingsScreen()),
                  );
                },
              ),
              ListTile(
                title: Text('About'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AboutScreen()),
                  );
                },
              ),
            ],
          ),
        ),
        body: ListView(
          children: [
            SizedBox(height: 50),
            WaterIntakeSummary(startOfWeek: provider.getStartOfWeek()),
            provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : provider.waterDataList.isEmpty
                ? const Center(child: Text("No water intake records yet."))
                : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: provider.waterDataList.length,
                    itemBuilder: (context, index) {
                      final waterData = provider.waterDataList[index];
                      return WaterTile(waterData: waterData);
                    },
                  ),
          ],
        ),
      ),
    );
  }

  void clearWaterTextController() {
    amountControler.clear();
  }
}
