import 'package:flutter/material.dart';
import 'package:journalmax/Pages/CollectionPage.dart';
import 'package:journalmax/Pages/EditorPage.dart';
import 'package:journalmax/Pages/FindDiary.dart';
import 'package:journalmax/Pages/Homepage.dart';
import 'package:journalmax/Pages/SettingsPage.dart';
import 'package:journalmax/Pages/SyncPage.dart';
import 'package:journalmax/Pages/ViewerPage.dart';
import 'package:journalmax/Themes/ThemeProvider.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  App({super.key});

  final Map<String, WidgetBuilder> routes = {
    "/homepage": (context) => const HomePage(),
    "/settings": (context) => const SettingsPage(),
    "/sync": (context) => const SyncPage(),
    "/view": (context) => ViewerPage(),
    "/find": (context) => const FindDiaryEntryPage(),
    "/editor": (context) => const EditorPage(),
    "/collection": (context) => const CollectionPage()
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: "JornalMax",
      theme: Provider.of<Themeprovider>(context).themeData,
      initialRoute: "/homepage",
      routes: routes,
    );
  }
}

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => Themeprovider(),
    child: App(),
  ));
}
