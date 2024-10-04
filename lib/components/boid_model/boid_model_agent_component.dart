import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:my_alife/my_parette.dart';

class BoidModelAgentComponent extends PositionComponent {
  double velocity = 1;

  final Paint paint = Paint()
    ..color = MyPalette.primary.color
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
    angle = random.nextDouble() * 2 * pi;
    position = Vector2(
      random.nextDouble() * 1000,
      random.nextDouble() * 1000,
    );
  }

  @override
  void render(Canvas canvas) {
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
  }

  void updateAngle() {}

  void updateVelocity() {}

  void updatePosition() {
    position += Vector2(
      velocity * cos(angle),
      velocity * sin(angle),
    );
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
    required List<BoidModelAgentComponent> otherAgentsInView,
  }) {}

  void alignment({
    required List<BoidModelAgentComponent> otherAgentsInView,
  }) {}

  void cohesion({
    required List<BoidModelAgentComponent> otherAgentsInView,
  }) {}
}
