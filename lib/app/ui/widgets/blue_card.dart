import 'package:blue_tine_interpreted_components/app/ui/widgets/blue_container.dart';
import 'package:flutter/material.dart';

class BlueCard extends StatelessWidget {
  const BlueCard({super.key, required this.title, required this.child});

  final Widget title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: title,
          ),
          Flexible(
              flex: 0,
              child: BlueContainer(child: child)),
        ],
      ),
    );
  }
}
