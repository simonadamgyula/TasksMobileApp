import 'package:flutter/material.dart';

class TaskComment extends StatelessWidget {
  const TaskComment({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Add a comment',
            contentPadding: const EdgeInsets.all(20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 1,
              ),
            ),
          ),
          maxLines: null,
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              'Send',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
