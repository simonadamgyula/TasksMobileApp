import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tasks/components/task_preview.dart';
import 'package:tasks/data/database.dart';

import 'data/task.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: "https://cdyinfjpithxtbnfstkp.supabase.co",
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNkeWluZmpwaXRoeHRibmZzdGtwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTY0MDgyMTAsImV4cCI6MjAzMTk4NDIxMH0.ATYXkyzjvATULrBsPnP7_I4xugx2vt3jyCdLvP5-IeQ",
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xff0c6efb), brightness: Brightness.light),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final futureTasks = TasksDatabase.getTasks();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).colorScheme.surfaceDim,
      body: SafeArea(
        child: FutureBuilder<List<Task>?>(
          future: futureTasks,
          builder: (context, AsyncSnapshot<List<Task>?> snapshot) {
            if (snapshot.hasError) {
              throw snapshot.error!;
            }
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }

            final tasks = snapshot.data!;

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final task in tasks) TaskPreview(task: task),
              ],
            );
          },
        ),
      ),
    );
  }
}
