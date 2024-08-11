import 'package:flutter/material.dart';
import 'package:tasks/components/status_selector.dart';
import 'package:tasks/components/task_comment.dart';
import 'package:tasks/components/time_edit.dart';

class TaskPreview extends StatefulWidget {
  const TaskPreview({super.key});

  @override
  State<TaskPreview> createState() => _TaskPreviewState();
}

class _TaskPreviewState extends State<TaskPreview> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  void showTaskBottomModal(BuildContext context, {String? task}) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text('Task details'),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: 'Task name',
                    border: InputBorder.none,
                  ),
                ),
                TextField(
                  controller: locationController,
                  decoration: const InputDecoration(
                    hintText: 'Task location',
                    border: InputBorder.none,
                  ),
                ),
                const TimeEdit(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Save'),
                ),
                const TaskComment(),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
              onTap: () {
                showTaskBottomModal(context, task: nameController.text);
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
                        child: TextField(
                          controller: nameController,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: const InputDecoration(
                            hintText: 'Task name',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.normal,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 0),
                          ),
                        ),
                      ),
                      const StatusSelector(
                        selected: 0,
                      ),
                    ],
                  ),
                  LocationHeightRow(
                    locationController: locationController,
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

class LocationHeightRow extends StatelessWidget {
  const LocationHeightRow({super.key, required this.locationController});

  final TextEditingController locationController;

  @override
  Widget build(BuildContext context) {
    return Row(
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
                child: TextField(
                  controller: locationController,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    height: 0.8,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Task location',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.normal,
                    ),
                    contentPadding: EdgeInsets.all(0),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
        const TimeEdit(),
      ],
    );
  }
}
