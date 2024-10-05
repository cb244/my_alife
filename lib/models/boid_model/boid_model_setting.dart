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
  double separationCoefficient = 40;
  double alignmentCoefficient = 0.01;
  double cohesionCoefficient = 1;

  // Distance of influence
  double separationDistance = 40;
  double alignmentDistance = 100;
  double cohesionDistance = 100;

  // Range of velocity
  double minVelocity = 0.5;
  double maxVelocity = 1;
}
