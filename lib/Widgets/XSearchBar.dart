import 'package:flutter/material.dart';

class XSearchBar extends StatelessWidget {
  final Function(String query)? searchFunction;

  const XSearchBar({super.key, this.searchFunction});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: colors.surface,
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
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                  fillColor: Colors.transparent,
                  hintText: "Search for an Entry...."),
              style: TextStyle(
                  color: colors.primary,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  decorationColor: Colors.transparent),
            ),
          ),
          const SizedBox(
            width: 15.0,
          ),
          IconButton(
            padding: const EdgeInsets.all(5.0),
            onPressed: () =>
                searchFunction!(controller.text) ?? () => print("Clicked"),
            style: ButtonStyle(
                shadowColor: WidgetStatePropertyAll(colors.shadow),
                backgroundColor: WidgetStatePropertyAll(colors.onSurface),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                    side: const BorderSide(),
                    borderRadius: BorderRadius.circular(10.0)))),
            icon: Icon(
              Icons.search,
              size: 40.0,
              color: colors.onPrimary,
              shadows: [
                BoxShadow(
                    color: colors.primary,
                    offset: const Offset(-1.5, -1.5),
                    blurRadius: 1.0),
                BoxShadow(
                    color: colors.shadow,
                    offset: const Offset(2.0, 2.0),
                    blurRadius: 1.0)
              ],
            ),
          )
        ],
      ),
    );
  }
}