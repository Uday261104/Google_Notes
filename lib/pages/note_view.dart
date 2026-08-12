import 'package:flutter/material.dart';
import 'package:google_notes/pages/colors.dart';
import 'package:google_notes/pages/edit_note.dart';

class NoteView extends StatefulWidget {
  final String heading;
  final String note;

  const NoteView({super.key, required this.heading, required this.note});

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
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.push_pin_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.archive_outlined),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditNote()),
              );
            },
            icon: const Icon(Icons.edit_outlined),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.heading,
              style: TextStyle(
                color: white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              widget.note,
              style: TextStyle(color: white.withOpacity(0.9), fontSize: 17),
            ),
          ],
        ),
      ),
    );
  }
}
