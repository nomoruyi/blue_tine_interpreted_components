import 'package:flutter/material.dart';

abstract class IBasePage extends StatefulWidget {
  const IBasePage(this.pageController, {super.key});

  final PageController pageController;

  @override
  State<IBasePage> createState() => IBasePageState();
}

class IBasePageState extends State<IBasePage> {
  late final PageController pageController = widget.pageController;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
