import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:journalmax/Widgets/XDialogButton.dart';
import 'package:journalmax/Widgets/XEntryItem.dart';
import 'package:journalmax/Widgets/XAppBar.dart';
import 'package:journalmax/Widgets/XDrawer.dart';
import 'package:journalmax/Widgets/XFloatingButton.dart';
import 'package:journalmax/Widgets/XIconLabelButton.dart';
import 'package:journalmax/services/CRUD_Entry.dart';

// ignore: must_be_immutable
class ViewerPage extends StatefulWidget {
  final int? Id;
  const ViewerPage({super.key, this.Id});

  @override
  State<ViewerPage> createState() => _ViewerPageState();
}

class _ViewerPageState extends State<ViewerPage> {
  Map<String, Color>? mood;
  Map<String, Object?>? Content;

  void setContent(Map<String, Object?> content) {
    setState(() {
      Content = content;
    });
  }

  void setMood(String Mood) {
    setState(() {
      mood = EntryItemMoods.NameToColor(Mood);
    });
  }

  Future<void> getEntry() async {
    if (kDebugMode) print('Id:${widget.Id}');
    final res = await getEntryById(widget.Id!);
    setContent(res.first);
    setMood(res.first["mood"].toString());
  }

  @override
  void initState() {
    getEntry();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mood ??= EntryItemMoods.happy;
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: XAppBar(
            title: "View Entry",
          )),
      drawer: const XDrawer(
        currentPage: "view",
      ),
      backgroundColor: colors.surface,
      body: Column(
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.075,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border: Border.all(color: colors.outline),
                  color: mood!["surface"],
                  boxShadow: [
                    BoxShadow(
                        color: mood!["text"] ?? colors.shadow,
                        offset: const Offset(1.5, 1.5)),
                    BoxShadow(
                        color: mood!["secondary"] ?? colors.outline,
                        offset: const Offset(-1.5, -1.5))
                  ],
                  borderRadius: BorderRadius.circular(10.0)),
              padding: const EdgeInsets.all(5.0),
              margin:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
              child: SelectableText(
                Content!["title"].toString(),
                style: TextStyle(color: mood!["text"], fontSize: 30.0),
                textAlign: TextAlign.center,
              )),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border: Border.all(color: colors.outline),
                  color: mood!["surface"],
                  boxShadow: [
                    BoxShadow(
                        color: mood!["text"] ?? colors.shadow,
                        offset: const Offset(1.5, 1.5)),
                    BoxShadow(
                        color: mood!["secondary"] ?? colors.outline,
                        offset: const Offset(-1.5, -1.5))
                  ],
                  borderRadius: BorderRadius.circular(10.0)),
              padding: const EdgeInsets.all(5.0),
              margin: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                  child: SelectableText(
                Content!["content"].toString(),
                style: TextStyle(color: mood!["secondary"], fontSize: 20.0),
              )),
            ),
          ),
          XIconLabelButton(
            icon: Icons.collections,
            label: "View memories in the entry",
            customFontSize: 19.0,
            onclick: () {
              ViewPageContentDialog(context, colors);
            },
          )
        ],
      ),
      floatingActionButton: XFloatingButton(
        icon: Icons.edit,
        //pass arguments later
        onclick: () => Navigator.pushNamed(context, "/editor"),
      ),
    );
  }

  Future<dynamic> ViewPageContentDialog(
      BuildContext context, ColorScheme colors) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            insetPadding: const EdgeInsets.only(top: 150),
            backgroundColor: colors.onSurface,
            actionsAlignment: MainAxisAlignment.start,
            alignment: Alignment.topCenter,
            shape: RoundedRectangleBorder(
                side: BorderSide(width: 2.0, color: colors.outline),
                borderRadius: BorderRadius.circular(15.0)),
            title: Center(
                child: Text(
              "View Memories",
              style: TextStyle(
                  color: colors.onPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0),
            )),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                XDialogButton(
                  colors: colors,
                  icon: Icons.book,
                  title: "View Diary Entry",
                  onclick: () => {},
                ),
                XDialogButton(
                  colors: colors,
                  icon: Icons.location_on,
                  title: "View where you were",
                  onclick: () => {},
                ),
                XDialogButton(
                  colors: colors,
                  icon: Icons.mic,
                  title: "View Voice Notes",
                  onclick: () => {},
                ),
                XDialogButton(
                  colors: colors,
                  icon: Icons.image,
                  title: "View Attached Images",
                  onclick: () => {},
                )
              ],
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel"))
            ],
          );
        });
  }
}
