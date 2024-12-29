import 'package:flutter/material.dart';

class XProgress extends StatelessWidget {
  final ColorScheme colors;
  const XProgress({super.key, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: colors.primary,
            strokeCap: StrokeCap.round,
          ),
          const Text("Loading.....")
        ],
      ),
    );
  }
}