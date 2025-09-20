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
  // Rating Feature
  int? selectedRating; // store chosen rating (1–5)

  // Algorithm Checkboxes
  Map<String, bool?> algorithms = {
    'Binary Search': false,
    'Linear Search': false,
    'Jump Search': false,
  };

  bool? selectAll = false; // tristate select all

  void updateSelectAll() {
    if (algorithms.values.every((value) => value == true)) {
      selectAll = true;
    } else if (algorithms.values.every((value) => value == false)) {
      selectAll = false;
    } else {
      selectAll = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rating + Algorithms Example'),
        backgroundColor: Colors.greenAccent[400],
      ),
      body: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: 430,
              height: 750,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Rating Section
                    const Text(
                      "The UI design is user-friendly:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // 5 checkboxes for rating 1–5
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(5, (index) {
                        int ratingValue = index + 1;
                        return Row(
                          children: [
                            Checkbox(
                              value: selectedRating == ratingValue,
                              onChanged: (bool? value) {
                                setState(() {
                                  if (value == true) {
                                    selectedRating = ratingValue;
                                  } else {
                                    selectedRating = null;
                                  }
                                });
                              },
                            ),
                            Text(ratingValue.toString()),
                          ],
                        );
                      }),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      selectedRating == null
                          ? "No rating selected"
                          : "Your Rating: $selectedRating / 5",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Divider(thickness: 2, height: 40),

                    // Algorithms Section
                    Text(
                      'Algorithms',
                      style: TextStyle(
                        color: Colors.greenAccent[400],
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),

                    // "Select All" Checkbox
                    Row(
                      children: [
                        Checkbox(
                          tristate: true,
                          value: selectAll,
                          onChanged: (bool? value) {
                            setState(() {
                              selectAll = value;
                              algorithms.updateAll(
                                  (key, oldValue) => value ?? false);
                            });
                          },
                        ),
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
                                updateSelectAll();
                              });
                            },
                          ),
                          Text(
                            key,
                            style: const TextStyle(fontSize: 17),
                          ),
                        ],
                      );
                    }).toList(),

                    const SizedBox(height: 20),

                    // Display selected algorithms
                    Text(
                      'Selected Algorithms: ' +
                          algorithms.entries
                              .where((entry) => entry.value == true)
                              .map((entry) => entry.key)
                              .join(', '),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
