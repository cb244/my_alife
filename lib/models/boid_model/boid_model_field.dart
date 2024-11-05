import 'dart:async';

import 'package:flame/game.dart';
import 'package:my_alife/components/boid_model/boid_model_agent_component.dart';
import 'package:my_alife/models/boid_model/boid_model_setting.dart';

class BoidModelField extends FlameGame {
  List<BoidModelAgentComponent> agents = [];

  @override
  Future<void> onLoad() async {
    super.onLoad();

    BoidModelSetting setting = BoidModelSetting();

    for (var i = 0; i < setting.agentNum; i++) {
      agents.add(
        BoidModelAgentComponent(
          setting: setting,
          fieldSize: size,
        ),
      );
    }

    await paintAgents();
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);

    for (var agent in agents) {
      agent.fieldSize = size;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    for (var agent in agents) {
      agent.separation(
        otherAgents: agents,
      );
      agent.alignment(
        otherAgents: agents,
      );
      agent.cohesion(
        otherAgents: agents,
      );

      agent.updateAcceleration();
      agent.updateVelocity();
      agent.updatePosition();
    }
  }

  Future<void> paintAgents() async {
    for (var agent in agents) {
      await add(agent);
    }
  }
}
