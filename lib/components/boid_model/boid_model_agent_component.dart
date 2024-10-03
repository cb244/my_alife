import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:my_alife/my_parette.dart';

class BoidModelAgentComponent extends PositionComponent {
  Vector2 velocity = Vector2.zero();

  BoidModelAgentComponent() : super(anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final Random random = Random();
    velocity = Vector2(
      random.nextDouble() * 2 - 1,
      random.nextDouble() * 2 - 1,
    );
    position = Vector2(
      random.nextDouble() * 1000,
      random.nextDouble() * 1000,
    );
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawCircle(
      Offset(position.x, position.y),
      10,
      MyPalette.primaryColor.paint(),
    );
  }

  void updateVelocity() {}

  void updatePosition() {
    position += velocity;
  }

  // Clip the position to the field size by periodic boundary condition
  void clipPosition(Vector2 fieldSize) {
    if (position.x / 2 < 0) {
      position.x += fieldSize.x / 2;
    } else if (position.x > fieldSize.x / 2) {
      position.x -= fieldSize.x / 2;
    }

    if (position.y < 0) {
      position.y += fieldSize.y / 2;
    } else if (position.y > fieldSize.y / 2) {
      position.y -= fieldSize.y / 2;
    }
  }
}
