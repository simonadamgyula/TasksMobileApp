import 'dart:developer';

import 'package:flutter/material.dart';

class Task {
  int id;
  String name;
  String location;
  String description;
  int status;
  TimeOfDay deadline;
  int? headCount;
  List<String>? workers;
  List<String>? notes;

  Task({
    required this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.status,
    required this.deadline,
    required this.headCount,
    required this.workers,
    required this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'description': description,
      'status': status,
      'due_date': [deadline.hour, deadline.minute],
      'head_count': headCount,
      'workers': workers,
      'notes': notes,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    final deadline = json["due_date"];

    return Task(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      description: json['description'],
      status: json['status'],
      deadline: TimeOfDay(hour: deadline[0], minute: deadline[1]),
      headCount: json['head_count'],
      workers: List<String>.from(json['workers'] ?? []),
      notes: List<String>.from(json['notes'] ?? []),
    );
  }
}