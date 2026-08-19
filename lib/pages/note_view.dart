import 'package:flutter/material.dart';
import 'package:google_notes/pages/colors.dart';
import 'package:google_notes/pages/edit_note.dart';
import 'package:google_notes/model/MyNoteModel.dart';
import 'package:google_notes/services/db.dart';
import 'package:google_notes/pages/home.dart';

class NoteView extends StatefulWidget {
  final Note note;

  const NoteView({super.key, required this.note});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,

      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0.0,
        iconTheme: IconThemeData(color: white.withOpacity(0.7)),
        actions: [
          // Pin
          IconButton(
            onPressed: () async {
              await NoteDatabase.instance.togglePin(widget.note);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            },
            icon: Icon(
              widget.note.pin ? Icons.push_pin : Icons.push_pin_outlined,
              color: white.withOpacity(0.7),
            ),
          ),

          // Archive
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.archive_outlined, color: white.withOpacity(0.7)),
          ),

          // Edit
          IconButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditNote(note: widget.note),
                ),
              );

              if (result == true && mounted) {
                Navigator.pop(context, true);
              }
            },
            icon: Icon(Icons.edit_outlined, color: white.withOpacity(0.7)),
          ),

          IconButton(
            onPressed: () async {
              final shouldDelete = await showDialog<bool>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Delete note?"),
                    content: const Text(
                      "Are you sure you want to delete this note?",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        child: const Text("Delete"),
                      ),
                    ],
                  );
                },
              );

              if (shouldDelete != true) return;

              await NoteDatabase.instance.deleteNote(widget.note.id!);

              if (!context.mounted) return;

              Navigator.pop(context, true);
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              widget.note.title,
              style: TextStyle(
                color: white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // Content
            Text(
              widget.note.content,
              style: TextStyle(color: white.withOpacity(0.9), fontSize: 17),
            ),
          ],
        ),
      ),
    );
  }
}
