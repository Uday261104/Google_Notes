import 'package:flutter/material.dart';
import 'package:google_notes/components/sidemenubar.dart';
import 'package:google_notes/pages/colors.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_notes/pages/create_note.dart';
import 'package:google_notes/pages/edit_note.dart';
import 'package:google_notes/pages/note_view.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey<ScaffoldState>();

  int selectedTab = 0;

  List<Map<String, String>> notes = [
    {"heading": "Shopping", "note": "Buy milk, vegetables and fruits."},
    {
      "heading": "Flutter",
      "note":
          "Learn ListView, GridView and StaggeredGridView. Understand how widgets are built dynamically and how to create responsive layouts.",
    },
    {
      "heading": "Work",
      "note": "Complete the project and push the code to GitHub.",
    },
    {
      "heading": "DSA",
      "note":
          "Practice arrays, strings, linked lists, stacks, queues, trees and graphs. Solve at least five problems today.",
    },
    {"heading": "College", "note": "Complete the assignment."},
    {
      "heading": "Python",
      "note":
          "Revise Python basics, functions, classes and exception handling. Practice writing clean and reusable code.",
    },
    {
      "heading": "Database",
      "note": "Learn SQL joins, normalization and indexing.",
    },
    {
      "heading": "Project Ideas",
      "note":
          "Build a notes application with search, categories, favorites and dark mode. Later add cloud synchronization and backup.",
    },
    {
      "heading": "Meeting",
      "note":
          "Discuss the project requirements, divide the tasks among team members and finalize the development timeline.",
    },
    {
      "heading": "Today",
      "note":
          "Finish Flutter UI, test the application on the emulator and fix any layout issues before pushing the changes.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateNote()),
          );
        },
        backgroundColor: cardColor,
        shape: const CircleBorder(),
        child: Icon(Icons.add, size: 45, color: white.withOpacity(0.7)),
      ),
      key: _drawerKey,
      drawer: const SideMenu(),
      endDrawerEnableOpenDragGesture: true,
      backgroundColor: bgColor,
      body: SafeArea(
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(overscroll: false),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SEARCH BAR
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
                        IconButton(
                          onPressed: () {
                            _drawerKey.currentState?.openDrawer();
                          },
                          icon: Icon(Icons.menu, color: white.withOpacity(0.7)),
                        ),
                        Expanded(
                          child: Text(
                            "Search the Notes.....",
                            style: TextStyle(
                              color: white.withOpacity(0.5),
                              fontSize: 16,
                            ),
                          ),
                        ),
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
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: white.withOpacity(0.7),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // ALL / FAVORITES
                  Row(
                    children: [
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

                  // MASONRY GRID
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
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NoteView(
                                  heading: notes[index]["heading"]!,
                                  note: notes[index]["note"]!,
                                ),
                              ),
                            );
                          },
                          child: noteContainer(
                            notes[index]["heading"]!,
                            notes[index]["note"]!,
                            index,
                          ),
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
