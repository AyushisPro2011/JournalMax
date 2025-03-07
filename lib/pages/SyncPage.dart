import 'package:flutter/material.dart';
import 'package:journalmax/widgets/ContentBox.dart';
import 'package:journalmax/widgets/XAppBar.dart';
import 'package:journalmax/widgets/XDrawer.dart';
import 'package:journalmax/widgets/XIconLabelButton.dart';
import 'package:journalmax/widgets/XSnackBar.dart';
import 'package:journalmax/services/UploadToGoogleDrive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SyncPage extends StatelessWidget {
  const SyncPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: XAppBar(
            title: "Synchronize",
          )),
      drawer: const XDrawer(
        currentPage: "sync",
      ),
      backgroundColor: colors.surface,
      body: Column(
        children: [
          SyncProgress(colors: colors),
          const XIconLabelButton(
            icon: Icons.add_to_drive,
            label: "Sync to Google Drive",
            onclick: uploadToGoogleDrive,
            customFontSize: 16.0,
          )
        ],
      ),
    );
  }
}

class SyncProgress extends StatefulWidget {
  const SyncProgress({
    super.key,
    required this.colors,
  });

  final ColorScheme colors;

  @override
  State<SyncProgress> createState() => _SyncProgressState();
}

class _SyncProgressState extends State<SyncProgress> {
  Future<void> getGmail() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String res = prefs.getString("gmail") ?? "Not found";
      setState(() {
        email = res;
      });
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  String email = "not Given";
  @override
  void initState() {
    getGmail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return contentBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                email,
                style: TextStyle(
                    color: widget.colors.onPrimary,
                    fontSize: 17.0,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
        colors: widget.colors);
  }
}
