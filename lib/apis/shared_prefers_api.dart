import 'package:radiov3/models/radio_station.dart';
import 'package:radiov3/utils/radiostation.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefApi {
  static const _key = 'radio_station';
  static Future<RadioStation> getInitalRadioStation() async {
    final sharedPrefs = await SharedPreferences.getInstance();

    final stationName = sharedPrefs.getString(_key);

    if (stationName == null) return RadioStations.allstations[0];
    return RadioStations.allstations
        .firstWhere((element) => element.nameURL == stationName);
  }

  static Future<void> setStation(RadioStation station) async {
    final sharedPrefs = await SharedPreferences.getInstance();

    sharedPrefs.setString(_key, station.nameURL);
  }
}
