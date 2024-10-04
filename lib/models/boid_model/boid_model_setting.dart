import 'package:flame/components.dart';

class BoidModelSetting {
  int agentNum = 1;
  Vector2 fieldSize;
  int viewRadius = 50;

  BoidModelSetting({
    required this.fieldSize,
  });

  void setFieldSize(Vector2 fieldSize) {
    this.fieldSize = fieldSize;
  }
}
