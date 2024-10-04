import 'dart:async';

import 'package:flame/game.dart';
import 'package:my_alife/models/boid_model/boid_model_setting.dart';
import 'package:my_alife/models/boid_model/boid_model_simulater.dart';

class BoidModelGame extends FlameGame {
  BoidModelSimulator? simulator;

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    if (simulator == null) return;
    simulator!.changeFieldSize(size);
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    BoidModelSetting setting = BoidModelSetting(fieldSize: size);
    simulator = BoidModelSimulator(setting: setting);
    await paintAgents();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (simulator == null) return;
    simulator!.simulateNextTime();
  }

  Future<void> paintAgents() async {
    if (simulator?.agents == null) return;
    for (var agent in simulator!.agents) {
      await add(agent);
    }
  }
}
