import 'package:flutter/material.dart';
import 'package:analog_digital_clock/constants/constants.dart';

class ClockContainer extends StatelessWidget {
  final Widget child;

  const ClockContainer({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Center(
          child: Container(
            width: 270,
            height: 270,
            decoration: const BoxDecoration(
              color: Color(darkSilver),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(4.0, 4.0),
                  blurRadius: 5.0,
                  spreadRadius: 0.5,
                ),
                BoxShadow(
                  color: Color(darkSilver),
                  offset: Offset(-4.0, -4.0),
                  blurRadius: 15.0,
                  spreadRadius: 1.0,
                ),
              ],
            ),
          ),
        ),
        Center(
          child: Container(
            width: 200,
            height: 200,
            decoration: const BoxDecoration(
              color: Color(silver),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(4.0, 4.0),
                  blurRadius: 5.0,
                  spreadRadius: 1.0,
                ),
                BoxShadow(
                  color: Color(silver),
                  offset: Offset(-4.0, -4.0),
                  blurRadius: 15.0,
                  spreadRadius: 1.0,
                ),
              ],
            ),
          ),
        ),
        Center(
          child: Container(
            width: 75,
            height: 75,
            decoration: const BoxDecoration(
              color: Color(silver),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(4.0, 4.0),
                  blurRadius: 5.0,
                  spreadRadius: 1.0,
                ),
                BoxShadow(
                  color: Color(silver),
                  offset: Offset(-4.0, -4.0),
                  blurRadius: 15.0,
                  spreadRadius: 1.0,
                ),
              ],
            ),
          ),
        ),
        Center(
          child: child,
        ),
        Center(
          child: Container(
            width: 10.0,
            height: 10.0,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(red),
            ),
          ),
        ),
      ],
    );
  }
}
