import 'package:flutter/material.dart';
import 'package:analog_digital_clock/constants/constants.dart';
//import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class FancyButton extends StatelessWidget {
  final String label;
  var onPress;
  final LinearGradient gradient;

  FancyButton(
      {super.key,
      required this.label,
      required this.onPress,
      required this.gradient});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      child: Ink(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Container(
          width: 120.0,
          height: 50.0,
          alignment: Alignment.center,
          child: Text(
            label,
            style: const TextStyle(
              color: Color(purple),
              fontFamily: 'Varela',
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
