import 'package:flutter/material.dart';
import 'package:journalmax/Widgets/XEntryItem.dart';

//TODO: implement the actual collection
List<Widget> getCollection() {
  return [
    XEntryItem(
      mood: EntryItemMoods.angry,
      title: "Lorem Ipsum dolor sit Amet iuerrvg iuesr",
      date: DateTime.now(),
    ),
    XEntryItem(
      mood: EntryItemMoods.anxious,
      title: "Lorem Ipsum dolor sit Amet iuerrvg iuesr",
      date: DateTime.now(),
    ),
    XEntryItem(
      mood: EntryItemMoods.doubtful,
      title: "Lorem Ipsum dolor sit Amet iuerrvg iuesr",
      date: DateTime.now(),
    ),
    XEntryItem(
      mood: EntryItemMoods.excited,
      title: "Lorem Ipsum dolor sit Amet iuerrvg iuesr",
      date: DateTime.now(),
    ),
    XEntryItem(
      mood: EntryItemMoods.frustrated,
      title: "Lorem Ipsum dolor sit Amet iuerrvg iuesr",
      date: DateTime.now(),
    ),
    XEntryItem(
      mood: EntryItemMoods.happy,
      title: "Lorem Ipsum dolor sit Amet iuerrvg iuesr",
      date: DateTime.now(),
    ),
    XEntryItem(
      mood: EntryItemMoods.mundane,
      title: "Lorem Ipsum dolor sit Amet iuerrvg iuesr",
      date: DateTime.now(),
    ),
    XEntryItem(
      mood: EntryItemMoods.sad,
      title: "Lorem Ipsum dolor sit Amet iuerrvg iuesr",
      date: DateTime.now(),
    ),
    XEntryItem(
      mood: EntryItemMoods.surprised,
      title: "Lorem Ipsum dolor sit Amet iuerrvg iuesr",
      date: DateTime.now(),
    ),
  ];
}
