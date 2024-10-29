import 'package:flutter/material.dart';

class BlueContainer extends StatelessWidget {
  const BlueContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: SizedBox(width: double.infinity, child: child),
      ),
    );
  }
}
