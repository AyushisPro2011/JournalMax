import 'package:flutter/material.dart';
import 'package:journalmax/Dialogs/moodChangeDialogEditorPage.dart';
import 'package:journalmax/Pages/ViewerPage.dart';
import 'package:journalmax/Pages/MultimediaAddPage.dart';
import 'package:journalmax/Widgets/XAppBar.dart';
import 'package:journalmax/Widgets/XDrawer.dart';
import 'package:journalmax/Widgets/XFloatingButton.dart';
import 'package:journalmax/Widgets/XIconLabelButton.dart';
import 'package:journalmax/Widgets/XProgress.dart';
import 'package:journalmax/Widgets/XSnackBar.dart';
import 'package:journalmax/models/EntryModel.dart';
import 'package:journalmax/services/CRUD_Entry.dart';
import 'package:journalmax/services/InsertEntry.dart';

// ignore: must_be_immutable
class EditorPage extends StatefulWidget {
  final bool? createNewEntry;
  int? UpdateId;

  EditorPage({super.key, this.createNewEntry = true, this.UpdateId});

  @override
  State<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  String currentMood = "Happy";
  String Location = "Not Entered";
  bool isLoading = false;
  Map<String, dynamic> moods = EntryItemMoods.happy;

  //CREATE
  Future<void> CreateEntry() async {
    try {
      await insertEntry(
          "Untitled", "", "Happy", DateTime.now().toString(), null, null, null);
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  Future<Map<String, dynamic>> getEntryDetailsById(int id) async {
    try {
      final res = await getEntryById(id);
      if (res.isNotEmpty) {
        return res.first; // Return the first entry if it exists
      } else {
        throw Exception("No entry found with ID $id");
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
      throw Exception(e);
    }
  }

  //READ
  Future<void> fetchExistingEntry(int id) async {
    try {
      final entryDetails = await getEntryDetailsById(id);
      setState(() {
        _titleController.text = entryDetails["title"] ?? "Untitled";
        _contentController.text = entryDetails["content"] ?? "";
        currentMood = entryDetails["mood"] ?? "Happy";
        moods = EntryItemMoods.NameToColor(currentMood);
        Location = entryDetails["location"] ?? "Not Given";
      });
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  //UPDATE
  Future<void> UpdateEntry() async {
    try {
      final int id;
      final entries = await getRecentEntries();
      id =
          widget.createNewEntry ?? true ? entries.last["id"] : widget.UpdateId!;
      await updateEntry(
        id,
        Entry(
            title: _titleController.text,
            Content: _contentController.text,
            mood: currentMood,
            date: DateTime.now().toString(),
            location: Location),
      );
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  Future<void> setUpdateIDForNewEntry() async {
    try {
      if (!widget.createNewEntry!) {
        return;
      }
      final result = await getRecentEntries();
      widget.UpdateId = result.last["id"];
      return;
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  void getLocationFromDialog(String ObtainedLocation) {
    Location = ObtainedLocation;
  }

  //UI
  void setCurrentMoodString(String mood) {
    setState(() {
      currentMood = mood;
      moods = EntryItemMoods.NameToColor(mood);
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0), () async {
      try {
        setState(() {
          isLoading = true;
        });
        if (widget.createNewEntry ?? true) {
          await CreateEntry();
        } else if (widget.UpdateId != null) {
          await fetchExistingEntry(widget.UpdateId!);
        }
        await setUpdateIDForNewEntry();
        setState(() {
          isLoading = false;
        });
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        showSnackBar(e.toString(), context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        await UpdateEntry();
        Navigator.pop(context);
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: XAppBar(title: "Editor Page"),
          ),
          drawer: const XDrawer(currentPage: "editor"),
          onDrawerChanged: (isOpened) => UpdateEntry(),
          backgroundColor: colors.surface,
          body: Column(
            children: [
              XIconLabelButton(
                icon: Icons.mood,
                label: "What's your current mood?",
                customFontSize: 16.5,
                onclick: () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return MoodChangeDialog(
                      returnMood: setCurrentMoodString,
                    );
                  },
                ),
              ),
              XIconLabelButton(
                  icon: Icons.image_outlined,
                  label: "Add Multimedia",
                  onclick: () => Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return MultimediaAddPage(
                          saveLocation: getLocationFromDialog,
                        );
                      }))),
              TitleBar(),
              ContentBox(context),
              XIconLabelButton(
                icon: Icons.save_as_rounded,
                label: "Save Entry",
                onclick: () async {
                  await UpdateEntry();
                  showSnackBar("Updated Entry", context);
                },
              ),
            ],
          ),
          floatingActionButton: XFloatingButton(
              icon: Icons.remove_red_eye_outlined,
              onclick: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return ViewerPage(
                    Id: widget.UpdateId ?? 1,
                  );
                }));
              })),
    );
  }

  Expanded ContentBox(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(5.0),
        child: isLoading
            ? XProgress(colors: Theme.of(context).colorScheme)
            : SingleChildScrollView(
                child: TextField(
                  controller: _contentController,
                  enabled: true,
                  style: TextStyle(color: moods["text"]),
                  decoration: InputDecoration(
                    hintText: "Enter your thoughts here!",
                    hintStyle: TextStyle(color: moods["secondary"]),
                    filled: true,
                    fillColor: moods["surface"],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: moods["secondary"]),
                    ),
                  ),
                  minLines: 12,
                  maxLines: 20,
                ),
              ),
      ),
    );
  }

  Padding TitleBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        autofocus: true,
        controller: _titleController,
        style: TextStyle(color: moods["text"]),
        decoration: InputDecoration(
          hintText: "Enter the title here...",
          hintStyle: TextStyle(color: moods["text"]),
          filled: true,
          fillColor: moods["surface"],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: moods["text"]),
          ),
        ),
      ),
    );
  }
}
