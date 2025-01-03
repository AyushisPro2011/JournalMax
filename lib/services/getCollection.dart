import 'package:flutter/material.dart';
import 'package:journalmax/Widgets/XEntryItem.dart';
import 'package:journalmax/models/EntryModel.dart';
import 'package:journalmax/services/CRUD_Entry.dart';

Future<List<Widget>> getCollection(void Function() renderParent) async {
  try {
    const Map<String, Color> Function(String query) NametoColor =
        EntryItemMoods.NameToColor;
    final List<Widget> EntryList = [];
    final Entries = await getAllEntry();
    for (var entry in Entries) {
      EntryList.add(XEntryItem(
          renderParent: renderParent,
          id: int.parse(entry["id"].toString()),
          mood: NametoColor(entry["mood"].toString()),
          date: entry["date"].toString(),
          title: entry["title"].toString()));
    }
    return EntryList;
  } catch (e) {
    throw Exception(e);
  }
}
