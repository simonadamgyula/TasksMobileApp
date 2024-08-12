import 'package:flutter/material.dart';

class Workers extends StatefulWidget {
  const Workers({super.key, required this.workers});

  final List<String> workers;

  @override
  State<Workers> createState() => _WorkersState();
}

class _WorkersState extends State<Workers> {
  List<String> workers = List.empty(growable: true);

  @override
  void initState() {
    workers.addAll(widget.workers);
    super.initState();
  }

  void addWorker() {
    setState(() {
      workers.add("New Worker");
    });
  }

  void removeWorker(String worker) {
    setState(() {
      workers.remove(worker);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          "Workers",
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Wrap(
          direction: Axis.horizontal,
          runAlignment: WrapAlignment.start,
          alignment: WrapAlignment.start,
          runSpacing: 5,
          spacing: 5,
          children: [
            for (final worker in workers)
              Worker(
                name: worker,
                onRemove: () {
                  removeWorker(worker);
                },
              ),
            AddWorkerButton(
              onAdd: addWorker,
            ),
          ],
        ),
      ],
    );
  }
}

class AddWorkerButton extends StatelessWidget {
  const AddWorkerButton({super.key, required this.onAdd});

  final void Function() onAdd;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onAdd,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 21,
        ),
      ),
    );
  }
}

class Worker extends StatelessWidget {
  const Worker({
    super.key,
    required this.name,
    required this.onRemove,
  });

  final String name;
  final void Function() onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            name,
            style: const TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: InkWell(
              onTap: onRemove,
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
