import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks/components/status_selector.dart';

class TaskPreview extends StatefulWidget {
  const TaskPreview({super.key});

  @override
  State<TaskPreview> createState() => _TaskPreviewState();
}

class _TaskPreviewState extends State<TaskPreview> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
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
      height: 120,
      margin: const EdgeInsets.all(10),
      child: Center(
        child: Row(
          children: [
            Container(
              width: 50,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.all(Radius.circular(14)),
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
                          decoration: const InputDecoration(
                            hintText: 'Task name',
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
                  TextField(
                    controller: locationController,
                    decoration: const InputDecoration(
                      hintText: 'Task location',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: -3),
                      icon: Icon(Icons.location_on_outlined, color: Colors.grey),
                    ),
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
