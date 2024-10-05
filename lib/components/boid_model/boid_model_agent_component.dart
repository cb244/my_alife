import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:my_alife/models/boid_model/boid_model_setting.dart';
import 'package:my_alife/my_parette.dart';

class BoidModelAgentComponent extends PositionComponent {
  final BoidModelAgentSetting setting;
  Vector2 velocity = Vector2.zero();
  Vector2 acceleration = Vector2.zero();
  Vector2 separationForce = Vector2.zero();
  Vector2 alignmentForce = Vector2.zero();
  Vector2 cohesionForce = Vector2.zero();

  final Paint paint = Paint()
    ..color = MyPalette.primary.color
    ..style = PaintingStyle.fill;

  BoidModelAgentComponent({required this.setting})
      : super(
          anchor: Anchor.center,
          size: Vector2(10, 15),
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final Random random = Random();

    angle = random.nextDouble() * 2 * pi;

    double normVelocity = setting.minVelocity +
        random.nextDouble() * (setting.maxVelocity - setting.minVelocity);
    velocity = Vector2(cos(angle), sin(angle)) * normVelocity;

    position = Vector2(
      random.nextDouble() * 1000,
      random.nextDouble() * 1000,
    );
  }

  @override
  void render(Canvas canvas) {
    // canvas.drawCircle(
    //   Offset.zero,
    //   setting.alignmentDistance,
    //   MyPalette.outline.paint()..style = PaintingStyle.stroke,
    // );

    super.render(canvas);

    final Vector2 centerLeft = Vector2(size.y / 2, 0);
    final Vector2 topRight = Vector2(-size.y / 2, size.x / 2);
    final Vector2 bottomRight = Vector2(-size.y / 2, -size.x / 2);

    final Path path = Path();
    path.moveTo(centerLeft.x, centerLeft.y);
    path.lineTo(topRight.x, topRight.y);
    path.lineTo(bottomRight.x, bottomRight.y);
    path.close();

    canvas.drawPath(path, paint);

    // final TextPainter painter = TextPainter(
    //   text: TextSpan(
    //     text: 'debug',
    //     style: TextStyle(
    //       fontSize: 10,
    //       color: MyPalette.onBackground.color,
    //     ),
    //   ),
    //   textDirection: TextDirection.ltr,
    // );
    // painter.layout();
    // painter.paint(canvas, Offset.zero);
  }

  void updateAcceleration() {
    acceleration = Vector2.zero();
    acceleration += separationForce * setting.separationCoefficient;
    acceleration += alignmentForce * setting.alignmentCoefficient;
    //acceleration += cohesionForce * setting.cohesionCoefficient;
  }

  void updateVelocity() {
    velocity += acceleration;
    if (velocity.length > setting.maxVelocity) {
      velocity = velocity.normalized() * setting.maxVelocity;
    } else if (velocity.length < setting.minVelocity) {
      velocity = velocity.normalized() * setting.minVelocity;
    }
  }

  void updatePosition() {
    position += velocity;
    angle = Vector2(1, 0).angleToSigned(velocity);
  }

  void clipPosition(Vector2 fieldSize) {
    // Clip the position to the field size by periodic boundary condition
    if (position.x < 0) {
      position.x += fieldSize.x;
    } else if (position.x > fieldSize.x) {
      position.x -= fieldSize.x;
    }

    if (position.y < 0) {
      position.y += fieldSize.y;
    } else if (position.y > fieldSize.y) {
      position.y -= fieldSize.y;
    }
  }

  void separation({
    required List<BoidModelAgentComponent> otherAgents,
  }) {
    separationForce = Vector2.zero();

    final List<BoidModelAgentComponent> agents = getAgentsWithinDistance(
      otherAgents: otherAgents,
      distance: setting.separationDistance,
    );
    for (var agent in agents) {
      Vector2 direction = (agent.position - position).normalized();
      double distance = position.distanceTo(agent.position);
      distance = max(distance, 0.1);
      separationForce -= direction / (distance * distance);
    }
    separationForce /= agents.length.toDouble();
  }

  void alignment({
    required List<BoidModelAgentComponent> otherAgents,
  }) {
    alignmentForce = Vector2.zero();

    final List<BoidModelAgentComponent> agents = getAgentsWithinDistance(
      otherAgents: otherAgents,
      distance: setting.alignmentDistance,
    );
    for (var agent in agents) {
      alignmentForce += agent.velocity - velocity;
    }
    alignmentForce /= agents.length.toDouble();
  }

  void cohesion({
    required List<BoidModelAgentComponent> otherAgents,
  }) {
    final List<BoidModelAgentComponent> agents = getAgentsWithinDistance(
      otherAgents: otherAgents,
      distance: setting.cohesionDistance,
    );
  }

  List<BoidModelAgentComponent> getAgentsWithinDistance({
    required List<BoidModelAgentComponent> otherAgents,
    required double distance,
  }) {
    return otherAgents.where((otherAgent) {
      return position.distanceTo(otherAgent.position) <= distance;
    }).toList();
  }
}
