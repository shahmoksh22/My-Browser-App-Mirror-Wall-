import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mirrorwall/Classes/BookMark.dart';
import 'package:mirrorwall/Provider/BookMarkProvider.dart';
import 'package:mirrorwall/Provider/ThemeProvider.dart';
import 'package:mirrorwall/Provider/PlatformProvider.dart';
import 'package:mirrorwall/Screens/WebViewPage.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    List<BookMark> displayItems = [
      BookMark(
        "https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-google-sva-scholarship-20.png",
        "https://www.google.com",
        "Google",
      ),
      BookMark(
        "https://static-00.iconduck.com/assets.00/duckduckgo-icon-2048x2048-bibao3k0.png",
        "https://www.duckduckgo.com",
        "DuckDuckGo",
      ),
      BookMark(
        "https://files.softicons.com/download/system-icons/windows-8-metro-icons-by-dakirby309/png/512x512/Internet%20Shortcuts%20&%20Manufacturers/Bing.png",
        "https://www.bing.com",
        "Bing",
      ),
      BookMark(
        "https://static-00.iconduck.com/assets.00/yahoo-icon-2048x568-kxhnao9a.png",
        "https://search.yahoo.com",
        "Yahoo",
      ),
      BookMark(
        "https://img.freepik.com/premium-vector/brave-browser-logo-symbol-isolated-white-background-internet-surfing-program-icon_337410-1958.jpg",
        "https://search.brave.com",
        "Brave Search",
      ),
    ];

    final isAndroid = Provider.of<PlatformProvider>(context).isandroid;
    final isDark = Provider.of<ThemeProvider>(context).isDark;

    return Scaffold(
      appBar: isAndroid
          ? AppBar(
              automaticallyImplyLeading: false,
              // Removes default back button
              title: Text(
                "Homepage",
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
              ],
            )
          : CupertinoNavigationBar(
              automaticallyImplyLeading: false, // Removes default back button
              middle: Text(
                "Homepage",
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
                ],
              ),
            ),
      body: SafeArea(
        child: Container(
          color: isDark ? Colors.black : Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "Please Select Your Search Engine.",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: isDark ? Colors.black : Colors.white,
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
                                    WebViewPage(initialUrl: item.Url)),
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
                                    const Icon(Icons.image_not_supported,
                                        size: 50),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                item.Title,
                                textAlign: TextAlign.center,
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
            ],
          ),
        ),
      ),
    );
  }
}
