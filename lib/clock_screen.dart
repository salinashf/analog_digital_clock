import 'dart:async';
import 'package:http/http.dart';
import 'dart:convert';
//import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:analog_digital_clock/constants/constants.dart';
import 'package:analog_digital_clock/modules/clock_container.dart';
import 'package:analog_digital_clock/modules/current_time_clock_hands.dart';
import 'package:analog_digital_clock/modules/fancy_button.dart';
import 'package:analog_digital_clock/modules/top_row.dart';
import 'package:analog_digital_clock/modules/world_time_clock_hands.dart';

import 'location_screen.dart';

enum Choice { WorldTime, CurrentTime }

class ClockPage extends StatefulWidget {
  @override
  ClockPageState createState() => ClockPageState();
}

class ClockPageState extends State<ClockPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  String locationName = "";
  String _formattedTime = '';
  late String worldTime;
  Choice choice = Choice.CurrentTime;

  String getTextLocationName(String location) {
    if (location != null) {
      List<String> newLoc;
      newLoc = location.split('/');
      return newLoc[newLoc.length - 1];
    } else
      return location;
  }

  @override
  void initState() {
    setInitialLocation();
//    _getLocationFromSharedPref();
    Timer.periodic(
        Duration(seconds: 1),
        (Timer t) =>
            choice == Choice.CurrentTime ? _getTime() : getWorldTime());
    super.initState();
  }

  setInitialLocation() async {
    locationName = await getLocationFromSharedPref();
  }

  Future<String> getLocationFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    final lastUsedLocation = prefs.getString('Location');

    return lastUsedLocation ?? 'Europe/London';
  }

  Future<void> setLocationPref(String location) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('Location', location);
  }

  void _getTime() {
    String formattedDateTime = DateFormat("hh:mm a").format(DateTime.now());
    if (this.mounted) {
      setState(() {
        _formattedTime = formattedDateTime;
      });
    }
  }

  void getWorldTime() async {
    if (await InternetConnectionChecker().hasConnection == false) {
      choice = Choice.CurrentTime;
      return null;
    }
    Response response =
        await get("http://worldtimeapi.org/api/timezone/$locationName" as Uri);
    Map worldData = jsonDecode(response.body);
    final String worldTimeString = worldData['datetime'];
    worldTime = worldTimeString.substring(11, 16);
    if (this.mounted) {
      setState(() {
        int meridian = int.parse(worldTime.substring(0, 2));
        if (meridian == 24) {
          worldTime = worldTime.replaceRange(0, 2, '00');
          _formattedTime = '$worldTime AM';
        } else if (meridian > 12) {
          meridian = meridian - 12;
          worldTime = worldTime.replaceRange(0, 2, '$meridian');
          _formattedTime = '$worldTime PM';
        } else if (meridian == 12) {
          worldTime = worldTime.replaceRange(0, 2, '$meridian');
          _formattedTime = '$worldTime PM';
        } else {
          _formattedTime = '$worldTime AM';
        }
      });
    }
  }

  dynamic checkConnection() async {
    bool check = await InternetConnectionChecker().hasConnection;
    return check;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color(silver),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            TopRow(
              title: 'WORLD CLOCK',
              onPress: () async {
                locationName = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LocationList(
                            selectedLocation: locationName,
                          );
                        },
                      ),
                    ) ??
                    'Europe/London';
                setLocationPref(locationName);
              },
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                child: Container(
                  child: Text(
                    "$_formattedTime",
                    style: kTimeTextStyle,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Center(
              child: ClockContainer(
                child: choice == Choice.CurrentTime
                    ? CustomPaint(
                        painter: CurrentTimeClockHands(),
                      )
                    : WorldTimeClockHands(
                        worldLocation: locationName,
                      ),
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FancyButton(
                  onPress: () async {
                    if (await InternetConnectionChecker().hasConnection == true) {
                      print('Has a Internet Connection');
                      choice = Choice.WorldTime;
                    } else {
                      choice = Choice.CurrentTime;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration(seconds: 3),
                          content: Text(
                            "No Internet Connection",
                            style: TextStyle(
                              fontFamily: 'Varela',
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      );


                    }
                  },
                  label: getTextLocationName(locationName),
                  gradient: choice == Choice.WorldTime
                      ? kActiveButtonGradient
                      : kInActiveButtonGradient,
                ),
                FancyButton(
                  onPress: () {
                    choice = Choice.CurrentTime;
                  },
                  label: 'Current Time',
                  gradient: choice == Choice.CurrentTime
                      ? kActiveButtonGradient
                      : kInActiveButtonGradient,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
