import 'package:flutter/material.dart';
import 'package:google_notes/components/archive.dart';
import 'package:google_notes/components/setting.dart';
import 'package:google_notes/pages/colors.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: bgColor),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Google Keep",
                      style: TextStyle(
                        color: white.withOpacity(0.8),
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Divider(color: white.withOpacity(0.3)),

                    const SizedBox(height: 10),

                    // ================= NOTES =================
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: selectedIndex == 0
                            ? white.withOpacity(0.12)
                            : Colors.transparent,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            selectedIndex = 0;
                          });

                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 12,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.lightbulb_outline,
                              size: 25,
                              color: white.withOpacity(0.8),
                            ),
                            const SizedBox(width: 15),
                            Text(
                              "Notes",
                              style: TextStyle(
                                color: white.withOpacity(0.8),
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 5),

                    // ================= ARCHIVED =================
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: selectedIndex == 1
                            ? white.withOpacity(0.12)
                            : Colors.transparent,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            selectedIndex = 1;
                          });

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Archive(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 12,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.archive_outlined,
                              size: 25,
                              color: white.withOpacity(0.7),
                            ),
                            const SizedBox(width: 15),
                            Text(
                              "Archived",
                              style: TextStyle(
                                color: white.withOpacity(0.7),
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 5),

                    // ================= SETTINGS =================
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: selectedIndex == 2
                            ? white.withOpacity(0.12)
                            : Colors.transparent,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            selectedIndex = 2;
                          });

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Setting(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 12,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.settings_outlined,
                              size: 25,
                              color: white.withOpacity(0.7),
                            ),
                            const SizedBox(width: 15),
                            Text(
                              "Settings",
                              style: TextStyle(
                                color: white.withOpacity(0.7),
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
