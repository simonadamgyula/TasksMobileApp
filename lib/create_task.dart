import 'package:flutter/material.dart';
import 'package:tasks/components/task_notes.dart';
import 'package:tasks/components/task_workers.dart';
import 'package:tasks/components/time_edit.dart';
import 'package:tasks/data/database.dart';
import 'package:tasks/decorations/add_field_decoration.dart';

import 'data/task.dart';

class CreateTaskPage extends StatelessWidget {
  const CreateTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          title: const Text("Create New Task"),
        ),
        body: const CreateTaskForm());
  }
}

class CreateTaskForm extends StatefulWidget {
  const CreateTaskForm({super.key});

  @override
  State<CreateTaskForm> createState() => _CreateTaskFormState();
}

class _CreateTaskFormState extends State<CreateTaskForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController headCountController = TextEditingController();
  TimeOfDay deadline = TimeOfDay.now();
  List<String> workers = List.empty();
  List<String> notes = List.empty();

  void onDeadlineChange(TimeOfDay deadline) {
    setState(() {
      this.deadline = deadline;
    });
  }

  void onWorkersEdit(List<String> workers) {
    setState(() {
      this.workers = workers;
    });
  }

  void onNotesEdit(List<String> notes) {
    setState(() {
      this.notes = notes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a name";
                    }
                    return null;
                  },
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: getFormFieldDecoration("Name"),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: TextFormField(
                    controller: locationController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a location";
                      }
                      return null;
                    },
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: getFormFieldDecoration("Location"),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: TextFormField(
                        controller: descriptionController,
                        decoration: const InputDecoration(
                          labelText: "Description",
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a description";
                          }
                          return null;
                        },
                        maxLines: null,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              const Text(
                                "Deadline",
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              TimeEdit(
                                onDeadlineChanged: (TimeOfDay deadline) {
                                  onDeadlineChange(deadline);
                                },
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: headCountController,
                            decoration: const InputDecoration(
                              labelText: "Head Count",
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return null;
                              }
                              if (int.tryParse(value) == null) {
                                return "Please enter a valid number";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (!formKey.currentState!.validate()) {
                          return;
                        }
                        
                        Task task = Task(
                          id: null,
                          status: 0,
                          name: nameController.text,
                          location: locationController.text,
                          description: descriptionController.text,
                          headCount: int.tryParse(headCountController.text),
                          deadline: deadline,
                          workers: workers,
                          notes: notes,
                        );
                        
                        await TasksDatabase.addTask(task);

                        if (!context.mounted) return;

                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Theme.of(context).colorScheme.onPrimary,
                        elevation: 5,
                      ),
                      child: const Text("Create Task"),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Workers(
                      workers: List.empty(),
                      onEdit: (List<String> workers) {
                        onWorkersEdit(workers);
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TaskNotes(
                      notes: List.empty(),
                      onEdit: (List<String> notes) {
                        onNotesEdit(notes);
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
