import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:my_alife/components/boid_model/boid_model_agent_component.dart';
import 'package:my_alife/models/boid_model/boid_model_setting.dart';

class BoidModelField extends FlameGame with TapCallbacks {
  List<BoidModelAgentComponent> agents = [];
  Vector2? tapPosition;

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
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    tapPosition = event.localPosition;
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    tapPosition = null;
  }

  @override
  void update(double dt) {
    super.update(dt);

    for (var agent in agents) {
      agent.separationPhase(
        fieldAgents: agents,
        tapPosition: tapPosition,
      );
      agent.alignmentPhase(
        fieldAgents: agents,
      );
      agent.cohesionPhase(
        fieldAgents: agents,
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
