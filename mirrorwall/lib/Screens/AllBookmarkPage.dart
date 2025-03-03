import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mirrorwall/Classes/BookMark.dart';
import 'package:mirrorwall/Provider/BookMarkProvider.dart';
import 'package:mirrorwall/Provider/ThemeProvider.dart';
import 'package:mirrorwall/Provider/PlatformProvider.dart';
import 'package:mirrorwall/Screens/WebViewPage.dart';
import 'package:provider/provider.dart';

class AllBookmarkPage extends StatefulWidget {
  const AllBookmarkPage({super.key});

  @override
  State<AllBookmarkPage> createState() => _AllBookmarkPageState();
}

class _AllBookmarkPageState extends State<AllBookmarkPage> {
  List<BookMark> defaultItems = [
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

  @override
  Widget build(BuildContext context) {
    final List<BookMark> displayItems =
        Provider.of<Bookmarkprovider>(context).bookmarks.isNotEmpty
            ? Provider.of<Bookmarkprovider>(context).bookmarks
            : defaultItems;

    final isAndroid = Provider.of<PlatformProvider>(context).isandroid;
    final isDark = Provider.of<ThemeProvider>(context).isDark;

    return Scaffold(
      appBar: isAndroid
          ? AppBar(
              automaticallyImplyLeading: false,
              // Removes default back button

              title: Text(
                "Bookmarks",
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              centerTitle: true,
              backgroundColor: isDark ? Colors.grey[900] : Colors.blue,
              actions: [
                IconButton(
                  icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
                  onPressed: () {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .changeTheme();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.android),
                  onPressed: () {
                    Provider.of<PlatformProvider>(context, listen: false)
                        .changeplatform();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () {
                    Navigator.pushNamed(context, "/");
                  },
                ),
              ],
            )
          : CupertinoNavigationBar(
              automaticallyImplyLeading: false, // Removes default back button

              middle: Text(
                "Bookmarks",
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              backgroundColor: isDark ? Colors.grey[900] : Colors.white,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Provider.of<ThemeProvider>(context, listen: false)
                          .changeTheme();
                    },
                    child: Icon(isDark
                        ? CupertinoIcons.moon_fill
                        : CupertinoIcons.sun_max_fill),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Provider.of<PlatformProvider>(context, listen: false)
                          .changeplatform();
                    },
                    child: Icon(CupertinoIcons.shuffle),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Navigator.pushNamed(context, "/");
                    },
                    child: Icon(CupertinoIcons.home),
                  ),
                ],
              ),
            ),
      body: SafeArea(
        child: Container(
          color: isDark ? Colors.black : Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isAndroid ? 2 : 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: isAndroid ? 1.5 : 1.2,
              ),
              itemCount: displayItems.length,
              itemBuilder: (context, index) {
                BookMark item = displayItems[index];

                return GestureDetector(
                  onTap: () {
                    print("Tapped on ${item.Url}");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              WebViewPage(initialUrl: "${item.Url}")),
                    );
                  },
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: isDark ? Colors.grey[800] : Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          item.Logo,
                          width: 50,
                          height: 50,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.image_not_supported, size: 50),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          item.Title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
