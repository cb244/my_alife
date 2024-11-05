import 'package:flutter/material.dart';
import 'package:my_alife/screens/boid_model/boid_model_game_widget.dart';

class BoidModelScreen extends StatelessWidget {
  const BoidModelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        title: Text(
          'Boid Model',
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: BoidModelGameWidget(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        selectedItemColor: Theme.of(context).colorScheme.onSurface,
        unselectedItemColor: Theme.of(context).colorScheme.outline,
        items: const [
          BottomNavigationBarItem(
            label: 'animation',
            icon: Icon(
              Icons.animation_rounded,
            ),
          ),
          BottomNavigationBarItem(
            label: 'about',
            icon: Icon(
              Icons.info_rounded,
            ),
          ),
          BottomNavigationBarItem(
            label: 'formula',
            icon: Icon(
              Icons.calculate_rounded,
            ),
          )
        ],
      ),
    );
  }
}
