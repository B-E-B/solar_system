import 'package:flutter/material.dart';
import 'package:solar_system/models/planet_model.dart';

class Planet extends StatelessWidget {
  final PlanetModel planet;
  final AnimationController controller;

  const Planet({
    super.key,
    required this.planet,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: planet.speed.toDouble()).animate(controller),
      alignment: Alignment.center,
      child: Padding(
          padding: EdgeInsets.only(top: planet.rangeFromSun),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Color(int.parse('0xff${planet.color.toRadixString(16).padLeft(6, '0')}')),
                BlendMode.color,
              ),
              child: Image(
                image: AssetImage('assets/images/planet.gif'),
                width: planet.size,
              ),
            ),
          )),
    );
  }
}
