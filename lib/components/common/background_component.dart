import 'package:flutter/material.dart';

class BackgroundComponent extends StatelessWidget {
  const BackgroundComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Theme.of(context).colorScheme.background,
    );
  }
}
