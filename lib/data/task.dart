import 'package:flutter/material.dart';

class Task {
  String name;
  String location;
  String description;
  int status;
  TimeOfDay deadline;
  int headCount;
  List<String> workers;
  List<String> notes;

  Task({
    required this.name,
    required this.location,
    required this.description,
    required this.status,
    required this.deadline,
    required this.headCount,
    required this.workers,
    required this.notes,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    final deadline = json["deadline"];

    return Task(
      name: json['name'],
      location: json['location'],
      description: json['description'],
      status: json['status'],
      deadline: TimeOfDay(hour: deadline[0], minute: deadline[1]),
      headCount: json['headCount'],
      workers: List<String>.from(json['workers']),
      notes: List<String>.from(json['notes']),
    );
  }
}