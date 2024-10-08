import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tasks/components/status_selector.dart';
import 'package:tasks/components/task_notes.dart';
import 'package:tasks/components/task_workers.dart';
import 'package:tasks/components/time_edit.dart';
import 'package:tasks/data/database.dart';

import '../data/task.dart';

extension TimeOfDayExtension on TimeOfDay {
  TimeOfDay addHour(int hour) {
    return replacing(hour: (this.hour + hour) % 24, minute: minute);
  }

  TimeOfDay removeHour(int hour) {
    return replacing(hour: (this.hour - hour) % 24, minute: minute);
  }
}

bool isBefore(TimeOfDay a, TimeOfDay b) {
  a = a.removeHour(10);
  b = b.removeHour(10);
  return a.hour < b.hour || (a.hour == b.hour && a.minute < b.minute);
}

class TaskPreview extends StatefulWidget {
  const TaskPreview({super.key, required this.task});

  final Task task;

  @override
  State<TaskPreview> createState() => _TaskPreviewState();
}

class _TaskPreviewState extends State<TaskPreview> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController headCountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  int status = 0;
  TimeOfDay deadline = TimeOfDay.now();

  @override
  void initState() {
    nameController.text = widget.task.name;
    locationController.text = widget.task.location;
    headCountController.text = widget.task.headCount.toString();
    descriptionController.text = widget.task.description;
    deadline = widget.task.deadline;
    status = widget.task.status;

    super.initState();
  }

  void onDeadlineChanged(TimeOfDay newDeadline) {
    setState(() {
      deadline = newDeadline;
    });
  }

  void onEdit() {
    TasksDatabase.updateTask(widget.task);
  }

  void showTaskBottomModal(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      isScrollControlled: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          snap: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Container(
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                padding: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onChanged: (String value) {
                          widget.task.name = value;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: TextField(
                          controller: locationController,
                          decoration: const InputDecoration(
                            labelText: 'Location',
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onChanged: (String value) {
                            widget.task.location = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: TextField(
                          controller: descriptionController,
                          decoration: const InputDecoration(
                            labelText: 'Description',
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onChanged: (String value) {
                            widget.task.description = value;
                          },
                          maxLines: null,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Deadline",
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                TimeEdit(
                                  onDeadlineChanged: (TimeOfDay deadline) {
                                    onDeadlineChanged(deadline);
                                    widget.task.deadline = deadline;
                                  },
                                  deadline: deadline,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: TextField(
                              controller: headCountController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: const InputDecoration(
                                labelText: 'Head count',
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onChanged: (String value) {
                                widget.task.headCount = int.tryParse(value);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Workers(
                        workers: widget.task.workers ?? [],
                        onEdit: (List<String> workers) {
                          widget.task.workers = workers;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TaskNotes(
                        notes: widget.task.notes ?? [],
                        onEdit: (List<String> notes) {
                          widget.task.notes = notes;
                        },
                      ),
                    ],
                  ),
                ) as Widget,
              ),
            );
          },
        );
      },
    );

    setState(() {});
    TasksDatabase.updateTask(widget.task);
  }

  @override
  Widget build(BuildContext context) {
    bool urgent = isBefore(deadline.removeHour(1), TimeOfDay.now());

    return IntrinsicHeight(
      child: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.all(Radius.circular(14)),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.shadow.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(4, 4),
            ),
          ],
        ),
        margin: const EdgeInsets.all(10),
        child: Row(
          children: [
            InkWell(
              onTap: () async {
                showTaskBottomModal(context);
              },
              child: Container(
                width: 50,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.all(Radius.circular(14)),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          nameController.text,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      StatusSelector(
                        selected: status,
                        onSelected: (int newStatus) {
                          setState(() {
                            status = newStatus;
                            widget.task.status = newStatus;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Icon(
                                Icons.location_on_outlined,
                                color: Colors.grey,
                                size: 20,
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  locationController.text,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    height: 0.8,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Text(
                              deadline.format(context),
                              style: TextStyle(
                                color: urgent ? Colors.red : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Icon(
                                Icons.access_time,
                                color: urgent ? Colors.red : Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
