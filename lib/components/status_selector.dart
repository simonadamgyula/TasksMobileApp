import 'package:flutter/material.dart';

class Status {
  final int value;
  final String name;

  const Status(this.value, this.name);
}

const List<Status> statuses = [
  Status(0, 'To Do'),
  Status(1, 'In Progress'),
  Status(2, 'Done'),
];

class StatusSelector extends StatefulWidget {
  const StatusSelector({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final int selected;
  final void Function(int) onSelected;

  @override
  State<StatusSelector> createState() => _StatusSelectorState();
}

class _StatusSelectorState extends State<StatusSelector> {
  int selected = 0;

  @override
  void initState() {
    setState(() {
      selected = widget.selected;
    });
    super.initState();
  }

  List<DropdownMenuItem<int>> getSelectables() {
    return statuses.map((status) {
      return DropdownMenuItem<int>(
        value: status.value,
        child: Text(status.name),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = switch (selected) {
      0 => Theme.of(context).colorScheme.secondary,
      1 => Theme.of(context).colorScheme.primary.withBlue(255),
      2 => Colors.green,
      _ => Theme.of(context).colorScheme.primary,
    };

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(14),
          bottomLeft: Radius.circular(14),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: DropdownButton<int>(
        underline: const SizedBox(),
        borderRadius: BorderRadius.circular(14),
        padding: const EdgeInsets.symmetric(vertical: 0),
        style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.bold),
        iconEnabledColor: Theme.of(context).colorScheme.onPrimary,
        dropdownColor: Theme.of(context).colorScheme.primary,
        value: selected,
        items: getSelectables(),
        onChanged: (int? value) {
          if (value == null) return;
          setState(() {
            selected = value;
          });
          widget.onSelected(value);
        },
      ),
    );
  }
}
