import 'package:flutter/material.dart';
import 'package:google_notes/components/sidemenubar.dart';
import 'package:google_notes/pages/colors.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_notes/pages/create_note.dart';
import 'package:google_notes/pages/note_view.dart';
import 'package:google_notes/services/db.dart';
import 'package:google_notes/model/MyNoteModel.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey<ScaffoldState>();

  final TextEditingController searchController = TextEditingController();

  int selectedTab = 0;

  // Notes currently displayed
  List<Note> notes = [];

  // Complete notes from database
  List<Note> allNotes = [];

  @override
  void initState() {
    super.initState();

    getNotes();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // CREATE
  Future<void> createEntry(Note note) async {
    final createdNote = await NoteDatabase.instance.create(note);

    print('Created note with ID: ${createdNote.id}');

    await getNotes();
  }

  // READ ALL
  Future<void> getNotes() async {
    final fetchedNotes = await NoteDatabase.instance.readNotes();

    if (!mounted) return;

    setState(() {
      allNotes = fetchedNotes;
      notes = fetchedNotes;
    });
  }

  // SEARCH
  void searchNotes(String value) {
    setState(() {
      if (value.isEmpty) {
        // Nothing typed → show all notes
        notes = allNotes;
      } else {
        // Something typed → search
        notes = allNotes.where((note) {
          final title = note.title.toLowerCase();

          final content = note.content.toLowerCase();

          final searchText = value.toLowerCase();

          return title.contains(searchText) || content.contains(searchText);
        }).toList();
      }
    });
  }

  // READ ONE
  Future<void> readNote(int id) async {
    final fetchedNote = await NoteDatabase.instance.readOneNote(id);

    if (fetchedNote != null) {
      setState(() {
        notes = [fetchedNote];
      });
    }
  }

  // UPDATE
  Future<void> updateNote(Note note) async {
    final updatedNote = await NoteDatabase.instance.updateNote(note);

    if (updatedNote != null) {
      await getNotes();
    }
  }

  // DELETE
  Future<void> deleteNote(int id) async {
    await NoteDatabase.instance.deleteNote(id);

    await getNotes();
  }

  Future<void> togglePin(Note note) async {
    await NoteDatabase.instance.togglePin(note);

    await getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,

      drawer: const SideMenu(),

      endDrawerEnableOpenDragGesture: true,

      backgroundColor: bgColor,

      // ADD NOTE
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateNote()),
          );

          if (result == true) {
            await getNotes();
          }
        },
        backgroundColor: cardColor,
        shape: const CircleBorder(),
        child: Icon(Icons.add, size: 45, color: white.withOpacity(0.7)),
      ),

      body: SafeArea(
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(overscroll: false),

          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,

                children: [
                  // =========================
                  // SEARCH BAR
                  // =========================
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),

                    height: 55,
                    width: double.infinity,

                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(27),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 3,
                        ),
                      ],
                    ),

                    child: Row(
                      children: [
                        // MENU BUTTON
                        IconButton(
                          onPressed: () {
                            _drawerKey.currentState?.openDrawer();
                          },

                          icon: Icon(Icons.menu, color: white.withOpacity(0.7)),
                        ),

                        // SEARCH FIELD
                        Expanded(
                          child: TextField(
                            controller: searchController,

                            keyboardType: TextInputType.text,

                            textInputAction: TextInputAction.search,

                            style: TextStyle(
                              color: white.withOpacity(0.7),
                              fontSize: 16,
                            ),

                            decoration: InputDecoration(
                              hintText: "Search the Notes...",

                              hintStyle: TextStyle(
                                color: white.withOpacity(0.7),
                                fontSize: 16,
                              ),

                              border: InputBorder.none,
                            ),

                            onChanged: searchNotes,
                          ),
                        ),

                        // GRID BUTTON
                        TextButton(
                          style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                              const CircleBorder(),
                            ),

                            minimumSize: WidgetStateProperty.all(
                              const Size(45, 45),
                            ),

                            padding: WidgetStateProperty.all(EdgeInsets.zero),

                            overlayColor: WidgetStateProperty.resolveWith(
                              (states) => white.withOpacity(0.1),
                            ),
                          ),

                          onPressed: () {
                            print("Grid button clicked");
                          },

                          child: Icon(
                            Icons.grid_view,
                            color: white.withOpacity(0.5),
                          ),
                        ),

                        // PROFILE
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: white.withOpacity(0.7),
                        ),

                        const SizedBox(width: 10),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // =========================
                  // ALL / FAVORITES
                  // =========================
                  Row(
                    children: [
                      // ALL
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedTab = 0;
                            });
                          },

                          child: Column(
                            children: [
                              Text(
                                "ALL",

                                style: TextStyle(
                                  color: white.withOpacity(
                                    selectedTab == 0 ? 1.0 : 0.5,
                                  ),

                                  fontSize: 12,

                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 8),

                              Container(
                                height: 2,
                                width: 60,

                                color: selectedTab == 0
                                    ? white
                                    : Colors.transparent,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // FAVORITES
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedTab = 1;
                            });
                          },

                          child: Column(
                            children: [
                              Text(
                                "FAVORITES",

                                style: TextStyle(
                                  color: white.withOpacity(
                                    selectedTab == 1 ? 1.0 : 0.5,
                                  ),

                                  fontSize: 12,

                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 8),

                              Container(
                                height: 2,
                                width: 60,

                                color: selectedTab == 1
                                    ? white
                                    : Colors.transparent,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  // =========================
                  // NOTES
                  // =========================
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),

                    child: MasonryGridView.count(
                      crossAxisCount: 2,

                      mainAxisSpacing: 5,

                      crossAxisSpacing: 5,

                      shrinkWrap: true,

                      physics: const NeverScrollableScrollPhysics(),

                      itemCount: notes.length,

                      itemBuilder: (context, index) {
                        final note = notes[index];

                        return InkWell(
                          onTap: () async {
                            final result = await Navigator.push(
                              context,

                              MaterialPageRoute(
                                builder: (context) => NoteView(note: note),
                              ),
                            );

                            if (result == true) {
                              await getNotes();
                            }
                          },

                          child: noteContainer(note.title, note.content, index),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // =========================
  // NOTE CONTAINER
  // =========================

  Widget noteContainer(String heading, String note, int index) {
    List<Color> noteColors = [Colors.green, Colors.blue, Colors.orange];

    return Container(
      margin: const EdgeInsets.all(2),

      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: noteColors[index % 3],

        borderRadius: BorderRadius.circular(12),

        border: Border.all(color: white.withOpacity(0.3), width: 1),
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            heading,

            style: TextStyle(
              color: white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            note,

            style: TextStyle(color: white.withOpacity(0.9), fontSize: 13),
          ),
        ],
      ),
    );
  }
}
