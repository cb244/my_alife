import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:my_alife/components/common/background_component.dart';
import 'package:my_alife/models/boid_model/boid_model_field.dart';

class BoidModelGameWidget extends StatelessWidget {
  const BoidModelGameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: BoidModelField(),
      backgroundBuilder: (context) => const BackgroundComponent(),
    );
  }
}
