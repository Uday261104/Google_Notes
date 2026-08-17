import 'package:flutter/material.dart';
import 'package:google_notes/pages/colors.dart';
import 'package:google_notes/model/MyNoteModel.dart';
import 'package:google_notes/services/db.dart';

class EditNote extends StatefulWidget {
  final Note note;

  const EditNote({super.key, required this.note});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  late final TextEditingController titleController;
  late final TextEditingController notesController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    // Put existing note data into the text fields
    titleController = TextEditingController(text: widget.note.title);

    notesController = TextEditingController(text: widget.note.content);
  }

  @override
  void dispose() {
    titleController.dispose();
    notesController.dispose();
    super.dispose();
  }

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
            splashRadius: 17,
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                // Get updated values from controllers
                final newTitle = titleController.text;
                final newContent = notesController.text;

                // Create updated Note
                final updatedNote = widget.note.copy(
                  title: newTitle,
                  content: newContent,
                );

                // Update database
                await NoteDatabase.instance.updateNote(updatedNote);

                // Go back
                if (mounted) {
                  Navigator.pop(context, true);
                }
              }
            },
            icon: Icon(Icons.save_outlined, color: white.withOpacity(0.7)),
          ),
        ],
      ),

      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Title
              TextFormField(
                controller: titleController,
                cursorColor: white,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  hintText: "Title",
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.withOpacity(0.8),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Title is required";
                  }

                  return null;
                },
              ),

              // Divider
              Divider(color: white.withOpacity(0.7)),

              // Notes
              Expanded(
                child: TextFormField(
                  controller: notesController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  expands: true,
                  cursorColor: white,
                  style: const TextStyle(fontSize: 18, color: white),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintText: "Notes",
                    hintStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.withOpacity(0.8),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Notes cannot be empty";
                    }

                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
