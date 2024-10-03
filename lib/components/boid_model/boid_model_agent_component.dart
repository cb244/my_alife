import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:my_alife/my_parette.dart';

class BoidModelAgentComponent extends PositionComponent {
  Vector2 velocity = Vector2.zero();
  final Paint paint = Paint()
    ..color = MyPalette.primaryColor.color
    ..style = PaintingStyle.fill;

  BoidModelAgentComponent()
      : super(
          anchor: Anchor.center,
          size: Vector2(10, 15),
        );

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
      Vector2.zero().toOffset(),
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
}
