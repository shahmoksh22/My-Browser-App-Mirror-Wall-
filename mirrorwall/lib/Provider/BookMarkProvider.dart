import 'package:flutter/material.dart';
import 'package:mirrorwall/Classes/BookMark.dart';

class Bookmarkprovider extends ChangeNotifier {
  List<BookMark> bookmarks = [
    BookMark(
      "https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-google-sva-scholarship-20.png",
      "https://www.google.com",
      "Google",
    ),
    BookMark(
      "https://upload.wikimedia.org/wikipedia/commons/1/17/Google-flutter-logo.png",
      "https://flutter.dev",
      "Flutter",
    ),
    BookMark(
      "https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png",
      "https://github.com",
      "GitHub",
    ),
  ];

  void addBookMarks(BookMark newitem) {
    bookmarks.add(newitem);
  }
}
