import 'package:flutter/material.dart';

class Workers extends StatefulWidget {
  const Workers({
    super.key,
    required this.workers,
    required this.onEdit,
  });

  final List<String> workers;
  final void Function(List<String>) onEdit;

  @override
  State<Workers> createState() => _WorkersState();
}

class _WorkersState extends State<Workers> {
  List<String> workers = List.empty(growable: true);
  bool isEditing = false;
  late FocusNode inputFocusNode;

  @override
  void initState() {
    workers.addAll(widget.workers);

    inputFocusNode = FocusNode();
    super.initState();
  }

  void startEditing() {
    setState(() {
      isEditing = true;
    });
    inputFocusNode.requestFocus();
  }

  void addWorker(String worker) {
    setState(() {
      workers.add(worker);
    });
    widget.onEdit(workers);
  }

  void removeWorker(String worker) {
    setState(() {
      workers.remove(worker);
    });
    widget.onEdit(workers);
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
            isEditing
                ? AddWorkerField(
                    focusNode: inputFocusNode,
                    addWorker: addWorker,
                    onFocusLost: () {
                      setState(() {
                        isEditing = false;
                      });
                    },
                  )
                : AddWorkerButton(
                    onAdd: startEditing,
                  ),
          ],
        ),
      ],
    );
  }
}

class AddWorkerField extends StatefulWidget {
  const AddWorkerField({
    super.key,
    required this.focusNode,
    required this.addWorker,
    required this.onFocusLost,
  });

  final FocusNode focusNode;
  final void Function(String) addWorker;
  final void Function() onFocusLost;

  @override
  State<AddWorkerField> createState() => _AddWorkerFieldState();
}

class _AddWorkerFieldState extends State<AddWorkerField> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      height: 31,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: const BorderRadius.all(
          Radius.circular(6),
        ),
      ),
      child: IntrinsicWidth(
        child: Focus(
          onFocusChange: (hasFocus) {
            if (!hasFocus) {
              controller.clear();
            }
          },
          child: TextField(
            cursorColor: Colors.white,
            cursorWidth: 1,
            cursorOpacityAnimates: true,
            focusNode: widget.focusNode,
            controller: controller,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 2),
              border: InputBorder.none,
              isDense: true,
              hintText: "Worker",
              hintStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            onEditingComplete: () {
              widget.addWorker(controller.text);
              controller.clear();
            },
          ),
        ),
      ),
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
          size: 16,
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
