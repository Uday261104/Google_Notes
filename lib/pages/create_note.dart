import 'package:flutter/material.dart';
import 'package:google_notes/model/MyNoteModel.dart';
import 'package:google_notes/pages/colors.dart';
import 'package:google_notes/services/db.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({super.key});
  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  Future<void> saveNote() async {
    final title = titleController.text.trim();
    final content = contentController.text.trim();

    if (title.isEmpty && content.isEmpty) {
      return;
    }

    final note = Note(
      pin: false,
      title: title,
      content: content,
      createdTime: DateTime.now(),
    );

    await NoteDatabase.instance.create(note);

    if (!mounted) return;

    Navigator.pop(context, true);
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
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
            onPressed: saveNote,
            icon: Icon(Icons.save_outlined, color: white.withOpacity(0.7)),
          ),
        ],
      ),

      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          children: [
            // Title
            TextField(
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
                disabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                hintText: "Title",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.withOpacity(0.8),
                ),
              ),
            ),

            // Divider
            Divider(color: white.withOpacity(0.7)),

            // Notes
            Expanded(
              child: TextField(
                controller: contentController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                expands: true,
                cursorColor: white,
                style: const TextStyle(fontSize: 18, color: white),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  hintText: "Notes",
                  hintStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.withOpacity(0.8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
