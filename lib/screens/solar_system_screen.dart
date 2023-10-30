import 'package:flutter/material.dart';
import 'package:solar_system/models/planet_model.dart';
import 'package:solar_system/widgets/planet.dart';

class SolarSystemScreen extends StatefulWidget {
  const SolarSystemScreen({super.key});
  @override
  State<SolarSystemScreen> createState() => _SolarSystemScreenState();
}

class _SolarSystemScreenState extends State<SolarSystemScreen> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  List<Planet> planetList = [];
  double maxRangeFromSun = 500;
  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );
    controller.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(
          radius: 1.5,
          colors: [
            Colors.grey.withOpacity(0.3),
            Colors.black,
            Colors.deepPurpleAccent.shade200.withOpacity(0.6),
            Colors.grey.withOpacity(0.5)
          ],
          stops: const [0.2, 0.4, 0.6, 1],
        )),
        child: Stack(children: [
          FittedBox(
            child: SizedBox(
              width: maxRangeFromSun,
              height: screenHeight / screenWidth * maxRangeFromSun,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  _sun(),
                  ...planetList,
                ],
              ),
            ),
          ),
          _bottomButton(context, Icons.delete_rounded, left: 20, onPressed: () {
            setState(() {
              planetList.clear();
              maxRangeFromSun = 500;
            });
          }),
          _bottomButton(context, Icons.add, right: 20, onPressed: () async {
            final newPlanet = await Navigator.pushNamed(context, '/new_planet');
            if (newPlanet is PlanetModel) {
              setState(() {
                planetList.add(Planet(
                  controller: controller,
                  planet: newPlanet,
                ));
                if (maxRangeFromSun < newPlanet.rangeFromSun + newPlanet.size) {
                  maxRangeFromSun = newPlanet.rangeFromSun + newPlanet.size;
                }
              });
            }
          }),
        ]),
      ),
    );
  }

  Widget _sun() {
    return Container(
      width: 80,
      height: 80,
      decoration:
          const BoxDecoration(gradient: RadialGradient(colors: [Colors.yellow, Colors.transparent], stops: [0.6, 1])),
    );
  }

  Widget _bottomButton(BuildContext context, IconData icon, {void Function()? onPressed, double? left, double? right}) {
    return Positioned(
        left: left,
        right: right,
        bottom: 20,
        child: Container(
            width: 55,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: IconButton(
              icon: Icon(
                icon,
                color: Colors.black,
                size: 33,
              ),
              onPressed: onPressed,
            )));
  }
}
