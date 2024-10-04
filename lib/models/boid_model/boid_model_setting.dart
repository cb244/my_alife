import 'package:flame/components.dart';

class BoidModelSetting {
  BoidModelAgentSetting agentSetting = BoidModelAgentSetting();
  int agentNum = 10;
  Vector2 fieldSize;

  BoidModelSetting({
    required this.fieldSize,
  });

  void setFieldSize(Vector2 fieldSize) {
    this.fieldSize = fieldSize;
  }
}

class BoidModelAgentSetting {
  // Coefficient of force
  double separationCoefficient = 10;
  double cohesionCoefficient = 1;
  double alignmentCoefficient = 1;

  // distance
  double separationDistance = 100;
  double cohesionDistance = 100;
  double alignmentDistance = 100;

  // Range of velocity
  double minVelocity = 0.5;
  double maxVelocity = 1;
}
