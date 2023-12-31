import 'package:flutter/material.dart';
import 'package:analog_digital_clock/constants/constants.dart';

class LocationList extends StatefulWidget {
  final String selectedLocation;
  const LocationList({super.key, required this.selectedLocation});

  @override
  _LocationListState createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(silver),
        body: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Center(
            child: getListView(),
          ),
        ),
      ),
    );
  }

  Widget getListView() {
    var listView = ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            TimeLocation[index],
            style: widget.selectedLocation == TimeLocation[index]
                ? kSelectedTextStyle
                : kTopRowTextStyle,
          ),
          onTap: () {
            Navigator.pop(context, TimeLocation[index]);
          },
        );
      },
      itemCount: 387,
    );
    return listView;
  }
}
