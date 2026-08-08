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