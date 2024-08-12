import 'package:flutter/material.dart';

class TimeEdit extends StatefulWidget {
  const TimeEdit({super.key, this.deadline, required this.onDeadlineChanged});

  final TimeOfDay? deadline;
  final void Function(TimeOfDay) onDeadlineChanged;

  @override
  State<TimeEdit> createState() => _TimeEditState();
}

class _TimeEditState extends State<TimeEdit> {
  TimeOfDay deadline = TimeOfDay.now();

  @override
  void initState() {
    if (widget.deadline != null) {
      setState(() {
        deadline = widget.deadline!;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final TimeOfDay? newDeadline = await showTimePicker(
          context: context,
          initialTime: deadline,
          initialEntryMode: TimePickerEntryMode.input,
          helpText: 'Enter deadline',
        );

        if (newDeadline != null) {
          setState(() {
            deadline = newDeadline;
            widget.onDeadlineChanged(deadline);
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              deadline.format(context),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Icon(
                Icons.access_time,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
