import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:my_alife/models/boid_model/boid_model_setting.dart';
import 'package:my_alife/my_parette.dart';

class BoidModelAgentComponent extends PositionComponent {
  final BoidModelSetting setting;
  Vector2 fieldSize;
  Vector2 velocityVector = Vector2.zero();
  Vector2 accelerationVector = Vector2.zero();

  Vector2 separationForceVector = Vector2.zero();
  Vector2 alignmentForceVector = Vector2.zero();
  Vector2 cohesionForceVector = Vector2.zero();

  final Paint paint = Paint()
    ..color = MyPalette.primary.color
    ..style = PaintingStyle.fill;

  BoidModelAgentComponent({
    required this.setting,
    required this.fieldSize,
  }) : super(
          anchor: Anchor.center,
          size: Vector2(10, 15),
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final Random random = Random();

    angle = random.nextDouble() * 2 * pi;

    double velocity = setting.minVelocity +
        random.nextDouble() * (setting.maxVelocity - setting.minVelocity);
    velocityVector = Vector2(cos(angle), sin(angle)) * velocity;

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
    accelerationVector = Vector2.zero();
    accelerationVector += separationForceVector * setting.separationCoefficient;
    accelerationVector += alignmentForceVector * setting.alignmentCoefficient;
    accelerationVector += cohesionForceVector * setting.cohesionCoefficient;
  }

  void updateVelocity() {
    velocityVector += accelerationVector;
    if (velocityVector.length > setting.maxVelocity) {
      velocityVector = velocityVector.normalized() * setting.maxVelocity;
    } else if (velocityVector.length < setting.minVelocity) {
      velocityVector = velocityVector.normalized() * setting.minVelocity;
    }
  }

  void updatePosition() {
    position += velocityVector;
    angle = Vector2(1, 0).angleToSigned(velocityVector);
    _clipPosition();
  }

  void _clipPosition() {
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

  Vector2 _getDistanceVector({
    required Vector2 otherPosition,
  }) {
    Vector2 distanceVector = otherPosition - position;

    if (distanceVector.x > fieldSize.x / 2) {
      distanceVector.x -= fieldSize.x;
    }
    if (distanceVector.x < -fieldSize.x / 2) {
      distanceVector.x += fieldSize.x;
    }

    if (distanceVector.y > fieldSize.y / 2) {
      distanceVector.y -= fieldSize.y;
    }
    if (distanceVector.y < -fieldSize.y / 2) {
      distanceVector.y += fieldSize.y;
    }

    return distanceVector;
  }

  void separation({
    required List<BoidModelAgentComponent> otherAgents,
  }) {
    separationForceVector = Vector2.zero();

    final List<BoidModelAgentComponent> agents = getAgentsWithinRadius(
      otherAgents: otherAgents,
      radius: setting.separationRadius,
    );
    for (var agent in agents) {
      Vector2 distanceVector = _getDistanceVector(
        otherPosition: agent.position,
      );
      Vector2 directionVector = distanceVector.normalized();
      double distance = max(distanceVector.length, 0.1);
      separationForceVector -= directionVector / (distance * distance);
    }
    separationForceVector /= agents.length.toDouble();
  }

  void alignment({
    required List<BoidModelAgentComponent> otherAgents,
  }) {
    alignmentForceVector = Vector2.zero();

    final List<BoidModelAgentComponent> agents = getAgentsWithinRadius(
      otherAgents: otherAgents,
      radius: setting.alignmentRadius,
    );
    for (var agent in agents) {
      alignmentForceVector += agent.velocityVector - velocityVector;
    }
    alignmentForceVector /= agents.length.toDouble();
  }

  void cohesion({
    required List<BoidModelAgentComponent> otherAgents,
  }) {
    cohesionForceVector = Vector2.zero();

    final List<BoidModelAgentComponent> agents = getAgentsWithinRadius(
      otherAgents: otherAgents,
      radius: setting.cohesionRadius,
    );
    for (var agent in agents) {
      cohesionForceVector += _getDistanceVector(
        otherPosition: agent.position,
      );
    }
    cohesionForceVector /= agents.length.toDouble();
  }

  List<BoidModelAgentComponent> getAgentsWithinRadius({
    required List<BoidModelAgentComponent> otherAgents,
    required double radius,
  }) {
    return otherAgents.where((otherAgent) {
      Vector2 distanceVector = _getDistanceVector(
        otherPosition: otherAgent.position,
      );
      return distanceVector.length <= radius;
    }).toList();
  }
}
