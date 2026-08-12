Flutter Context — Short Note

context tells Flutter where a widget is located in the widget tree.

Uses:
• Theme.of(context) → Get theme information
• MediaQuery.of(context) → Get screen size
• Navigator.of(context) → Navigate between screens

In ListView.builder:
context → Location of the widget in the widget tree
index → Position of the current item

Easy to remember:
context = "Where am I in the widget tree?"


Note:

This widget is here in the widget tree, so use the information available at this location.