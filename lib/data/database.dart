import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tasks/data/task.dart';

class TasksDatabase {
  static final supabase = Supabase.instance.client;

  static Future<List<Task>?> getTasks() async {
    final data = await supabase.from('Tasks').select();
    log(data.toString());
    return data.map((task) => Task.fromJson(task)).toList();
  }

  static Future<Task?> getTask(int id) async {
    final data = await supabase.from('Tasks').select().eq('id', id);
    return Task.fromJson(data[0]);
  }

  static Future<void> addTask(Task task) async {
    await supabase.from('Tasks').upsert(task.toJson());
  }

  static Future<void> updateTask(Task task) async {
    await supabase.from('Tasks').update(task.toJson()).eq('id', task.id!);
  }

  static Future<void> deleteTask(int id) async {
    await supabase.from('Tasks').delete().eq('id', id);
  }

  static Future<void> deleteAllTasks() async {
    await supabase.from('Tasks').delete();
  }
}
