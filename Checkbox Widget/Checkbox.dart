import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Changed from single bool? to a map to manage multiple checkboxes
  Map<String, bool?> algorithms = {
    'Binary Search': false,
    'Linear Search': false,
    'Jump Search': false,
  };

  bool? selectAll = false; // Added "Select All" tristate checkbox

  // Helper method to update "Select All" checkbox based on individual selections
  void updateSelectAll() {
    if (algorithms.values.every((value) => value == true)) {
      selectAll = true;
    } else if (algorithms.values.every((value) => value == false)) {
      selectAll = false;
    } else {
      selectAll = null; // Indeterminate state
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GeeksforGeeks'),
        backgroundColor: Colors.greenAccent[400],
        leading: IconButton(
          icon: const Icon(Icons.menu),
          tooltip: 'Menu',
          onPressed: () {},
        ),
      ),
      body: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              width: 430,
              height: 700,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Algorithms',
                    style: TextStyle(
                      color: Colors.greenAccent[400],
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // "Select All" Checkbox
                  Row(
                    children: [
                      Checkbox(
                        tristate: true,
                        value: selectAll,
                        onChanged: (bool? value) {
                          setState(() {
                            selectAll = value;
                            // Set all checkboxes to the value of selectAll
                            algorithms.updateAll((key, oldValue) => value ?? false);
                          });
                        },
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Select All Algorithms',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),

                  const Divider(),

                  // List of individual checkboxes
                  ...algorithms.keys.map((String key) {
                    return Row(
                      children: [
                        Checkbox(
                          tristate: true,
                          value: algorithms[key],
                          onChanged: (bool? value) {
                            setState(() {
                              algorithms[key] = value;
                              updateSelectAll(); // Update "Select All" state
                            });
                          },
                        ),
                        const SizedBox(width: 10),
                        Text(
                          key,
                          style: const TextStyle(fontSize: 17),
                        ),
                      ],
                    );
                  }).toList(),

                  const SizedBox(height: 30),

                  // Display current selection status
                  Text(
                    'Selected Algorithms: ' +
                        algorithms.entries
                            .where((entry) => entry.value == true)
                            .map((entry) => entry.key)
                            .join(', '),
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}