import 'package:flame/components.dart';

class BoidModelSetting {
  BoidModelAgentSetting agent;
  BoidModelFieldSetting field;
  int agentNum = 50;

  BoidModelSetting({
    required this.agent,
    required this.field,
  });

  void setFieldSize(Vector2 fieldSize) {
    field = BoidModelFieldSetting(size: fieldSize);
  }
}

class BoidModelAgentSetting {
  // Coefficient of force
  double separationCoefficient = 50;
  double alignmentCoefficient = 0.01;
  double cohesionCoefficient = 0.0005;

  // Distance of influence
  double separationDistance = 50;
  double alignmentDistance = 100;
  double cohesionDistance = 100;

  // Range of velocity
  double minVelocity = 0.5;
  double maxVelocity = 1;
}

class BoidModelFieldSetting {
  Vector2 size;

  BoidModelFieldSetting({
    required this.size,
  });

  setSize(Vector2 size) {
    this.size = size;
  }
}
