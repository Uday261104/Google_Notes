import 'package:flutter/material.dart';
import 'package:google_notes/components/sidemenubar.dart';
import 'package:google_notes/pages/colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawerEnableOpenDragGesture: true,
      key: _drawerKey,
      drawer: SideMenu(),
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                width: MediaQuery.of(context).size.width,
                height: 55,
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
                    // Menu
                    IconButton(
                      onPressed: () {
                        _drawerKey.currentState!.openDrawer();
                      },
                      icon: Icon(Icons.menu, color: white.withOpacity(0.7)),
                    ),

                    // Search text
                    Expanded(
                      child: Text(
                        "Search the Notes.....",
                        style: TextStyle(
                          color: white.withOpacity(0.5),
                          fontSize: 16,
                        ),
                      ),
                    ),

                    // Grid
                    TextButton(
                      style: ButtonStyle(
                        shape: WidgetStateProperty.all(const CircleBorder()),
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

                    // Profile
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: white.withOpacity(0.7),
                    ),

                    const SizedBox(width: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
