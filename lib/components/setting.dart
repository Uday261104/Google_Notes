import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool value = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF202124),

      appBar: AppBar(
        backgroundColor: const Color(0xFF202124),
        elevation: 0,
        title: const Text(
          "Settings",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Sync",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),

            Transform.scale(
              scale: 0.9,
              child: Switch.adaptive(
                value: value,
                onChanged: (newValue) {
                  setState(() {
                    value = newValue;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
