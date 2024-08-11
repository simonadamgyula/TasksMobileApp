import 'package:flutter/material.dart';

class TimeEdit extends StatefulWidget {
  const TimeEdit({super.key});

  @override
  State<TimeEdit> createState() => _TimeEditState();
}

class _TimeEditState extends State<TimeEdit> {
  TimeOfDay deadline = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.all(0),
      onPressed: () async {
        final TimeOfDay? newDeadline = await showTimePicker(
          context: context,
          initialTime: deadline,
          initialEntryMode: TimePickerEntryMode.input,
          helpText: 'Enter deadline',
        );

        if (newDeadline != null) {
          setState(() {
            deadline = newDeadline;
          });
        }
      },
      child: Row(
        children: [
          Text(deadline.format(context)),
          const Padding(
            padding: EdgeInsets.only(left: 8),
            child: Icon(
              Icons.access_time,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
