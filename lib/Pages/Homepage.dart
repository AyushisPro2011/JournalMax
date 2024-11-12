import 'package:flutter/material.dart';
import 'package:journalmax/Widgets/XAppBar.dart';
import 'package:journalmax/Widgets/XDrawer.dart';
import 'package:journalmax/Widgets/XIconLabelButton.dart';
import 'package:journalmax/Widgets/XLabel.dart';
import 'package:journalmax/services/RecentEntries.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: XAppBar(
            title: "Homepage",
          )),
      drawer: const XDrawer(
        currentPage: "homepage",
      ),
      backgroundColor: colors.surface,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const XLabel(label: "Recent Entries"),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  color: colors.onSurface,
                  border: Border.all(color: colors.outline),
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                        color: colors.primary,
                        offset: const Offset(-1.5, -1.5),
                        blurRadius: 1.0),
                    BoxShadow(
                        color: colors.shadow,
                        offset: const Offset(2.0, 2.0),
                        blurRadius: 1.0),
                  ]),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: recentEntries(),
                ),
              ),
            ),
          ),
          const XLabel(label: "Options"),
          const XIconLabelButton(
            icon: Icons.auto_awesome_sharp,
            label: "Get a random memory",
          ),
          XIconLabelButton(
            icon: Icons.sync_sharp,
            label: "Synchronize your Diary",
            onclick: () => Navigator.pushReplacementNamed(context, "/sync"),
          ),
          XIconLabelButton(
            icon: Icons.search_sharp,
            label: "Find an Entry",
            onclick: () => Navigator.pushReplacementNamed(context, "/find"),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape:
            CircleBorder(side: BorderSide(color: colors.outline, width: 1.0)),
        foregroundColor: colors.primary,
        backgroundColor: colors.onPrimary,
        child: Icon(
          Icons.add,
          size: 40.0,
          shadows: [
            BoxShadow(
              color: colors.shadow,
              offset: const Offset(-1.0, -1.0),
            ),
            BoxShadow(
              color: colors.tertiary,
              offset: const Offset(1.0, 1.0),
            ),
          ],
        ),
      ),
    );
  }
}
