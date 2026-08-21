import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController ammountControler = TextEditingController();
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
                controller: ammountControler,
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
            TextButton(onPressed: () {}, child: Text("Save")),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4.4,
        title: Text("Water Intake", style: TextStyle(color: Colors.white)),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.map))],
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      floatingActionButton: FloatingActionButton(
        onPressed: addWater,
        child: const Icon(Icons.add),
      ),
    );
  }
}
