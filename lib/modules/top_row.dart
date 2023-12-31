import 'package:flutter/material.dart';
import 'package:analog_digital_clock/constants/constants.dart';

class TopRow extends StatelessWidget {
  final String title;
  var  onPress;
  TopRow({super.key, required this.title, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(silver),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Ink(
              decoration: const BoxDecoration(
                gradient: kInActiveButtonGradient,
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              child: Container(
                height: 45.0,
                width: 45.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: IconButton(
                  onPressed: onPress,
                  icon: const Icon(
                    Icons.drag_handle,
                    color: Color(purple),
                  ),
                ),
              ),
            ),
            Text(
              title,
              style: kTopRowTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
