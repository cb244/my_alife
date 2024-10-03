import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:my_alife/components/common/background_component.dart';
import 'package:my_alife/games/boid_model/boid_model_game.dart';

class BoidModelScreen extends StatelessWidget {
  const BoidModelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Boid Model',
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GameWidget(
          game: BoidModelGame(),
          backgroundBuilder: (context) => const BackgroundComponent(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            label: 'animation',
            icon: Icon(Icons.animation_rounded),
          ),
          BottomNavigationBarItem(
            label: 'about',
            icon: Icon(Icons.info_rounded),
          ),
          BottomNavigationBarItem(
            label: 'formula',
            icon: Icon(Icons.calculate_rounded),
          )
        ],
      ),
    );
  }
}
