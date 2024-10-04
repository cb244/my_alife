import 'package:flame/components.dart';
import 'package:my_alife/components/boid_model/boid_model_agent_component.dart';
import 'package:my_alife/models/boid_model/boid_model_setting.dart';

class BoidModelSimulator {
  List<BoidModelAgentComponent> agents = [];
  final BoidModelSetting setting;

  BoidModelSimulator({required this.setting}) {
    for (var i = 0; i < setting.agentNum; i++) {
      agents.add(
        BoidModelAgentComponent(
          setting: setting.agentSetting,
        ),
      );
    }
  }

  void changeFieldSize(Vector2 fieldSize) {
    setting.setFieldSize(fieldSize);
  }

  void simulateNextTime() {
    for (var agent in agents) {
      agent.separation(otherAgents: agents);
      //agent.alignment(otherAgents: agents);
      //agent.cohesion(otherAgents: agents);

      agent.updateAcceleration();
      agent.updateVelocity();
      agent.updatePosition();
      agent.clipPosition(setting.fieldSize);
    }
  }
}
