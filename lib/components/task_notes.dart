import 'package:flutter/material.dart';

class TaskNotes extends StatefulWidget {
  const TaskNotes({
    super.key,
    required this.notes,
    required this.onEdit,
  });

  final List<String> notes;
  final void Function(List<String>) onEdit;

  @override
  State<TaskNotes> createState() => _TaskNotesState();
}

class _TaskNotesState extends State<TaskNotes> {
  void onAddNote(String note) {
    setState(() {
      widget.notes.add(note);
    });
    widget.onEdit(widget.notes);
  }

  void onEditNote(int index, String newNote) {
    setState(() {
      if (newNote.isEmpty) {
        widget.notes.removeAt(index);
        return;
      }
      widget.notes[index] = newNote;
    });
    widget.onEdit(widget.notes);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Notes",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 10),
          AddNote(
            onAddNote: onAddNote,
          ),
          for (final (index, note) in widget.notes.indexed)
            Note(
              note: note,
              onEdit: (String newNote) => onEditNote(index, newNote),
            ),
        ],
      ),
    );
  }
}

class Note extends StatefulWidget {
  const Note({
    super.key,
    required this.note,
    required this.onEdit,
  });

  final String note;
  final void Function(String) onEdit;

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  final TextEditingController noteController = TextEditingController();
  bool edited = false;

  @override
  void initState() {
    noteController.text = widget.note;
    noteController.addListener(() {
      if (noteController.text != widget.note) {
        setState(() {
          edited = true;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: edited ? const EdgeInsets.only(bottom: 22) : null,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 1,
              ),
            ),
            child: TextField(
              controller: noteController,
              maxLines: null,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(20),
              ),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
          ),
          if (edited)
            Positioned(
              right: 0,
              bottom: -4,
              child: ElevatedButton(
                onPressed: () {
                  widget.onEdit(noteController.text);
                  setState(() {
                    edited = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class AddNote extends StatefulWidget {
  const AddNote({
    super.key,
    required this.onAddNote,
  });

  final void Function(String) onAddNote;

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 22),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 1,
            ),
          ),
          child: TextField(
            controller: noteController,
            decoration: const InputDecoration(
              hintText: 'Add a note',
              contentPadding: EdgeInsets.all(20),
              border: InputBorder.none,
            ),
            maxLines: null,
          ),
        ),
        Positioned(
          right: 0,
          bottom: -4,
          child: ElevatedButton(
            onPressed: () {
              widget.onAddNote(noteController.text);
              noteController.clear();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
              ),
            ),
            child: const Text(
              'Add',
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
