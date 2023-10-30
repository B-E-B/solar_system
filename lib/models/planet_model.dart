class PlanetModel {
  int color;
  double size;
  int speed;
  double rangeFromSun;
  PlanetModel({
    required this.color,
    required this.size,
    required this.speed,
    required this.rangeFromSun,
  });
  PlanetModel copyWith({color, size, speed, rangeFromSun}) => PlanetModel(
        color: color ?? this.color,
        size: size ?? this.size,
        speed: speed ?? this.speed,
        rangeFromSun: rangeFromSun ?? this.rangeFromSun,
      );
}
