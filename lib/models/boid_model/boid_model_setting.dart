class BoidModelSetting {
  int agentNum = 20;

  // Coefficient of force
  double separationCoefficient = 50;
  double alignmentCoefficient = 0.01;
  double cohesionCoefficient = 0.0005;

  // Radius of influence
  double separationRadius = 50;
  double alignmentRadius = 100;
  double cohesionRadius = 100;

  // Range of velocity
  double minVelocity = 0.5;
  double maxVelocity = 1;
}
