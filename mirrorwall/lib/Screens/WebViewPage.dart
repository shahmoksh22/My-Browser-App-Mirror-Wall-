import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mirrorwall/Classes/BookMark.dart';
import 'package:mirrorwall/Provider/BookMarkProvider.dart';
import 'package:provider/provider.dart';

class WebViewPage extends StatefulWidget {
  final String? initialUrl; // Accepts a URL when navigating

  WebViewPage({this.initialUrl});

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  String _pageTitle = "WebView";
  InAppWebViewController? _webViewController;
  int _selectedIndex = 0; // Default selected index
  String _homeUrl = "https://www.google.com"; // Default homepage

  @override
  void initState() {
    super.initState();
    if (widget.initialUrl != null) {
      _homeUrl = widget.initialUrl!; // Set initial URL if provided
    }
  }

  Future<bool> _onWillPop() async {
    if (_webViewController != null) {
      bool canGoBack = await _webViewController!.canGoBack();
      if (canGoBack) {
        _webViewController!.goBack();
        return false; // Prevents app from closing
      }
    }
    return true; // Allows app to close
  }

  void _addBookmark() async {
    var url = await _webViewController?.getUrl();
    var title = await _webViewController?.getTitle();
    var favicons = await _webViewController?.getFavicons();

    if (url != null && title != null) {
      String? faviconUrl;

      if (favicons != null && favicons.isNotEmpty) {
        favicons.sort((a, b) =>
            (b.width ?? 0) * (b.height ?? 0) -
            (a.width ?? 0) * (a.height ?? 0));
        faviconUrl = favicons.first.url.toString();
      }

      Provider.of<Bookmarkprovider>(context, listen: false).addBookMarks(
        BookMark(
          faviconUrl!,
          url.toString(),
          title,
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bookmark added!')),
      );
    }
  }

  void _goHome() {
    _webViewController?.loadUrl(
      urlRequest: URLRequest(url: WebUri(_homeUrl)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          // Removes default back button

          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/bookmark');
              },
              icon: Icon(Icons.bookmark),
            )
          ],
          centerTitle: true,
          title: Text(_pageTitle, style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: [
            Expanded(
              child: InAppWebView(
                initialUrlRequest: URLRequest(
                  url: WebUri(_homeUrl), // Uses passed URL or default
                ),
                onWebViewCreated: (controller) {
                  _webViewController = controller;
                },
                onTitleChanged: (controller, title) {
                  setState(() {
                    _pageTitle = title ?? "WebView";
                  });
                },
              ),
            ),
            BottomNavigationBar(
              currentIndex: _selectedIndex,
              backgroundColor: Colors.blue,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.black,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  label: 'Back',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.arrow_forward, color: Colors.black),
                  label: 'Forward',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.home, color: Colors.black),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bookmark, color: Colors.black),
                  label: 'Bookmark',
                ),
              ],
              onTap: (index) async {
                setState(() {
                  _selectedIndex = index;
                });

                switch (index) {
                  case 0:
                    if (await _webViewController?.canGoBack() ?? false) {
                      _webViewController?.goBack();
                    }
                    break;
                  case 1:
                    if (await _webViewController?.canGoForward() ?? false) {
                      _webViewController?.goForward();
                    }
                    break;
                  case 2:
                    _goHome();
                    break;
                  case 3:
                    _addBookmark();
                    break;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
