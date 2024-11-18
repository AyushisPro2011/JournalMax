import 'package:flutter/material.dart';
import 'package:journalmax/Widgets/XAppBar.dart';
import 'package:journalmax/Widgets/XDrawer.dart';
import 'package:journalmax/Widgets/XEntryItem.dart';
import 'package:journalmax/models/EntryModel.dart';
import 'package:journalmax/services/CRUD_Entry.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: XAppBar(
            title: "NOT FOR PRODUCTION",
          )),
      drawer: const XDrawer(
        currentPage: "Test",
      ),
      backgroundColor: colors.surface,
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                print(getEntry("Query"));
              },
              child: Text("GET")),
          ElevatedButton(
              onPressed: () {
                deleteEntry("query");
              },
              child: Text("DELETE")),
          ElevatedButton(
              onPressed: () {
                updateEntry(
                    "query",
                    Entry(
                        title: "Title",
                        Content: "Lorem Ipsum Dolor Amet",
                        mood: EntryItemMoods.happy,
                        date: DateTime.now()));
              },
              child: Text("UPDATE")),
          ElevatedButton(
              onPressed: () {
                pushEntry(Entry(
                    Content: "Lorem Ipsum Dolor Amet blah blah blah",
                    title: "pushEntry",
                    date: DateTime.now(),
                    mood: EntryItemMoods.frustrated));
              },
              child: Text("PUSH"))
        ],
      ),
    );
  }
}
