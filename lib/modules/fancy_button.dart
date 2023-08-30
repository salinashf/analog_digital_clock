import 'package:flutter/material.dart';
import 'package:analog_digital_clock/constants/constants.dart';
//import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neumorphic_button/neumorphic_button.dart';

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
    Size size = MediaQuery.of(context).size;
    return NeumorphicButton(
      borderRadius: 12,
      bottomRightShadowBlurRadius: 15,
      bottomRightShadowSpreadRadius: 1,
      borderWidth: 5,
      backgroundColor: Colors.grey.shade500,
      topLeftShadowBlurRadius: 15,
      topLeftShadowSpreadRadius: 1,
      topLeftShadowColor: Colors.blue,
      bottomRightShadowColor: Colors.grey.shade500,
      height: size.width * 0.2,
      width: size.width * 0.2,
      padding: const EdgeInsets.all(50),
      bottomRightOffset: Offset(4, 4),
      topLeftOffset: Offset(-4, -4),
      onTap: onPress,
      child: const Text(
       "dasdasdasd",
        style: TextStyle(
          color: Color(purple),
          fontFamily: 'Varela',
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
