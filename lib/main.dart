import 'package:flutter/material.dart';
import 'package:tasks/components/task_preview.dart';

import 'data/task.dart';

void main() {
  runApp(const MyApp());
}

final List<Task> tasks = [
  Task(
    name: "Task 1",
    location: "Location 1",
    description: "Description 1",
    status: 0,
    deadline: const TimeOfDay(hour: 12, minute: 0),
    headCount: 1,
    workers: ["Worker 1"],
    notes: ["Note 1"],
  ),
  Task(
    name: "Task 2",
    location: "Location 2",
    description: "Description 2",
    status: 1,
    deadline: const TimeOfDay(hour: 12, minute: 0),
    headCount: 1,
    workers: ["Worker 1", "Worker 2"],
    notes: ["Note 1", "Note 2"],
  ),
  Task(
    name: "Task 3",
    location: "Location 3",
    description: "Description 3",
    status: 2,
    deadline: const TimeOfDay(hour: 12, minute: 0),
    headCount: 1,
    workers: ["Worker 1", "Worker 2", "Worker 3"],
    notes: ["Note 1", "Note 2", "Note 3"],
  ),
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff0c6efb), brightness: Brightness.light),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceDim,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final task in tasks)
                TaskPreview(task: task),
            ],
          )
        ),
      ),
    );
  }
}

