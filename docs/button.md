//make the icon and test both clickable

TextButton.icon(
  onPressed: () {
    print("Home clicked");
  },
  icon: Icon(
    Icons.home,
    color: white,
  ),
  label: Text(
    "Home",
    style: TextStyle(
      color: white,
    ),
  ),
)


GestureDetector is used to detect user actions like tapping, swiping, long-pressing, etc.