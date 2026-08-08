import 'package:flutter/material.dart';
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
        color: bgColor,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 20, 25, 10),
                child: Text(
                  "Google Keep",
                  style: TextStyle(
                    color: white.withOpacity(0.8),
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Divider(
                color: white.withOpacity(0.2),
                thickness: 1,
              ),

              const SizedBox(height: 10),

              // Notes
              menuItem(
                index: 0,
                icon: Icons.lightbulb_outline,
                title: "Notes",
              ),

              // Archived
              menuItem(
                index: 1,
                icon: Icons.archive_outlined,
                title: "Archived",
              ),

              const Spacer(),

              // Settings
              menuItem(
                index: 2,
                icon: Icons.settings_outlined,
                title: "Settings",
              ),

              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  Widget menuItem({
    required int index,
    required IconData icon,
    required String title,
  }) {
    bool isSelected = selectedIndex == index;

    return Container(
      margin: const EdgeInsets.only(
        right: 10,
        bottom: 5,
      ),
      decoration: BoxDecoration(
        color: isSelected
            ? white.withOpacity(0.12)
            : Colors.transparent,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
        ),
        onPressed: () {
          setState(() {
            selectedIndex = index;
          });

          print("$title clicked");
        },
        child: Row(
          children: [
            Icon(
              icon,
              size: 25,
              color: isSelected
                  ? white
                  : white.withOpacity(0.7),
            ),

            const SizedBox(width: 15),

            Text(
              title,
              style: TextStyle(
                color: isSelected
                    ? white
                    : white.withOpacity(0.7),
                fontSize: 17,
                fontWeight: isSelected
                    ? FontWeight.w600
                    : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


---> How to use this


menuItem(
  index: 0,
  icon: Icons.lightbulb_outline,
  title: "Notes",
  page: const Home(),
),

menuItem(
  index: 1,
  icon: Icons.archive_outlined,
  title: "Archived",
  page: const Archived(),
),

menuItem(
  index: 2,
  icon: Icons.settings_outlined,
  title: "Settings",
  page: const Settings(),
),