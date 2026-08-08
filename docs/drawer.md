FLUTTER DRAWER – SHORT NOTES

1. What is Drawer?
Drawer is a side menu that slides from the left.
Example: Home, Settings, Profile, Logout.

2. Normal Drawer
Use when you use Flutter's normal AppBar.

Scaffold(
  appBar: AppBar(),
  drawer: Drawer(),
)

Flutter automatically provides the ☰ button and opens the Drawer.

3. Drawer with GlobalKey
Use when you create your own/custom ☰ menu button.

Create key:
final GlobalKey<ScaffoldState> _scaffoldKey =
    GlobalKey<ScaffoldState>();

Give key to Scaffold:
Scaffold(
  key: _scaffoldKey,
  drawer: Drawer(),
)

Open Drawer:
_scaffoldKey.currentState?.openDrawer();

4. Difference
Normal Drawer → Flutter handles the menu button.
GlobalKey Drawer → You control your own menu button.

5. currentState
_scaffoldKey.currentState
= gets the current Scaffold connected to the key.

6. ?
_scaffoldKey.currentState?.openDrawer();

? means:
"If currentState exists → open Drawer.
If it doesn't exist → do nothing."

Easy rule:
Normal AppBar → No GlobalKey needed.
Custom menu button → Use GlobalKey.


User taps menu
      ↓
Scaffold not created yet
      ↓
currentState = null
      ↓
? checks it
      ↓
Nothing happens
      ↓
Scaffold gets created
      ↓
User taps menu again
      ↓
currentState exists
      ↓
Drawer opens ✅