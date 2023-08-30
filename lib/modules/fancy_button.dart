import 'package:flutter/material.dart';
import 'package:analog_digital_clock/constants/constants.dart';

class FancyButton extends StatelessWidget {
  final String label;
  final Function onPress;
  final LinearGradient gradient;

  FancyButton({required this.label, required this.onPress, required this.gradient});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Ink(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Container(
          width: 120.0,
          height: 50.0,
          alignment: Alignment.center,
          child: Text(
            '$label',
            style: TextStyle(
              color: Color(purple),
              fontFamily: 'Varela',
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      onPressed: onPress,
    );
  }
}
