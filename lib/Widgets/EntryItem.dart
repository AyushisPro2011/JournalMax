import 'package:flutter/material.dart';

final class EntryItemMoods {
  static Map<String, Color> angry = {
    "surface": Colors.red.shade200,
    "text": Colors.blue.shade800,
    "date": Colors.purple.shade900
  };

  static Map<String, Color> sad = {
    "surface": Colors.blueGrey.shade300,
    "text": Colors.blue.shade600,
    "date": Colors.indigo.shade900
  };

  static Map<String, Color> happy = {
    "surface": Colors.yellow.shade300,
    "text": Colors.orange.shade700,
    "date": Colors.green.shade700
  };

  static Map<String, Color> excited = {
    "surface": Colors.orange.shade300,
    "text": Colors.deepOrange.shade600,
    "date": Colors.redAccent.shade700
  };

  static Map<String, Color> mundane = {
    "surface": Colors.grey.shade300,
    "text": Colors.grey.shade700,
    "date": Colors.brown.shade700
  };

  static Map<String, Color> surprised = {
    "surface": Colors.purple.shade200,
    "text": Colors.indigo.shade700,
    "date": Colors.deepPurple.shade900
  };

  static Map<String, Color> frustrated = {
    "surface": Colors.redAccent.shade100,
    "text": Colors.red.shade700,
    "date": Colors.deepOrange.shade900
  };

  static Map<String, Color> doubtful = {
    "surface": Colors.blueGrey.shade200,
    "text": Colors.blue.shade700,
    "date": Colors.indigo.shade900
  };

  static Map<String, Color> anxious = {
    "surface": Colors.orange.shade100,
    "text": Colors.brown.shade800,
    "date": Colors.red.shade700
  };
}

class EntryItem extends StatelessWidget {
  final Map<String, Color> mood;
  final String title;
  final DateTime date;
  const EntryItem(
      {super.key, required this.mood, required this.date, required this.title});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Container(
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
          color: mood["surface"],
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          boxShadow: [
            BoxShadow(color: mood["date"]!, offset: Offset(1.5, 1.5)),
            BoxShadow(color: mood["text"]!, offset: Offset(-1.5, -1.5))
          ]),
      padding: EdgeInsets.all(5.0),
      margin: EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 15.0,
          ),
          Icon(
            Icons.circle,
            size: 10.0,
            color: colors.primary,
          ),
          SizedBox(width: 20.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 20.0,
                      color: mood.isEmpty ? colors.primary : mood["text"]),
                  maxLines: 1,
                ),
                Text(
                  '${date.year}/${date.month}/${date.day}',
                  style: TextStyle(
                      fontSize: 15.0,
                      color: mood.isEmpty ? colors.primary : mood["date"]),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}