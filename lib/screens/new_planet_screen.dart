import 'package:flutter/material.dart';
import 'package:solar_system/models/planet_model.dart';
import 'package:rxdart/rxdart.dart';

class NewPlanetScreen extends StatelessWidget {
  NewPlanetScreen({super.key});
  final BehaviorSubject<PlanetModel> _planetSubject = BehaviorSubject.seeded(PlanetModel(
    size: 45,
    color: 2345678,
    speed: 1,
    rangeFromSun: 5,
  ));
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlanetModel>(
        stream: _planetSubject.stream,
        builder: (context, snapshot) {
          final PlanetModel? planet = snapshot.data;
          if (planet == null) {
            return const SizedBox();
          }
          return Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.black, Colors.black, Colors.deepPurple],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 80,
                    child: Icon(
                      Icons.language,
                      size: planet.size,
                      color: Color(int.parse('0xff${planet.color.toRadixString(16).padLeft(6, '0')}')),
                    ),
                  ),
                  _paramSlider('Размер', planet.size, (double value) {
                    _planetSubject.add(_planetSubject.value.copyWith(size: value));
                  }, min: 10, max: 80, divisions: 70),
                  _paramSlider('Цвет', planet.color.toDouble(), (double value) {
                    _planetSubject.add(_planetSubject.value.copyWith(color: value.toInt()));
                  }, min: 0, max: 256 * 256 * 256, divisions: 100),
                  _paramSlider('Расстояние от Солнца', planet.rangeFromSun, (double value) {
                    _planetSubject.add(_planetSubject.value.copyWith(rangeFromSun: value));
                  }, min: 1, max: 100, divisions: 100),
                  _paramSlider('Скорость', planet.speed.toDouble(), (double value) {
                    _planetSubject.add(_planetSubject.value.copyWith(speed: value.toInt()));
                  }, min: -10, max: 10, divisions: 20),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context, planet.copyWith(rangeFromSun: planet.rangeFromSun * 100));
                      },
                      child: Container(
                        width: 60,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Center(
                          child: Text(
                            'OK',
                            style: TextStyle(color: Colors.deepPurple, fontSize: 24, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          );
        });
  }

  Column _paramSlider(String title, double currentSliderValue, void Function(double)? onChanged,
      {double min = 1, double max = 100, int divisions = 99}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Text('$title:  ${currentSliderValue.toInt()}',
              style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w300)),
        ),
        Slider(
          value: currentSliderValue,
          min: min,
          max: max,
          divisions: divisions,
          thumbColor: Colors.white,
          activeColor: Colors.white,
          inactiveColor: Colors.deepPurple,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
