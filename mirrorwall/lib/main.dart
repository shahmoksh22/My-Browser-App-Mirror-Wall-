import 'package:flutter/material.dart';
import 'package:mirrorwall/Provider/BookMarkProvider.dart';
import 'package:mirrorwall/Screens/AllBookmarkPage.dart';
import 'package:mirrorwall/Provider/PlatformProvider.dart';
import 'package:mirrorwall/Provider/ThemeProvider.dart';
import 'package:mirrorwall/Screens/HomePage.dart';
import 'package:provider/provider.dart';
import 'package:mirrorwall/Screens/WebViewPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => PlatformProvider()),
        ChangeNotifierProvider(create: (context) => Bookmarkprovider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Define the initial route
      routes: {
        '/': (context) => Homepage(),
        '/bookmark': (context) => AllBookmarkPage(), // Example additional route
      },
    );
  }
}
