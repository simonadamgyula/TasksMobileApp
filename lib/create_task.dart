import 'package:flutter/material.dart';
import 'package:tasks/components/task_notes.dart';
import 'package:tasks/components/task_workers.dart';
import 'package:tasks/components/time_edit.dart';
import 'package:tasks/decorations/add_field_decoration.dart';

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

class CreateTaskForm extends StatelessWidget {
  const CreateTaskForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextFormField(
                  decoration: getFormFieldDecoration("Name"),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: TextFormField(
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
                                  // TODO: Implement deadline editing
                                },
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
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
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Workers(
                      workers: List.empty(),
                      onEdit: (List<String> workers) {
                        // TODO: Implement workers editing
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TaskNotes(
                      notes: List.empty(),
                      onEdit: (List<String> notes) {
                        // TODO: Implement notes editing
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
