import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_player/radio_player.dart';
import 'package:radiov3/models/radio_station.dart';
import 'package:radiov3/providers/radio_provider.dart';

class RadioApi {
  static late RadioPlayer player;
  static Future<void> initPlayer(BuildContext context) async {
    final provider = Provider.of<RadioProvider>(context, listen: false);

    player = RadioPlayer();

    player.stop();
    await player.setChannel(
        title: provider.station.nameURL, url: provider.station.streamURL);

    await player.play();
  }

  static Future<void> changeStation(RadioStation station) async {
    player.stop();
    await player.setChannel(title: station.nameURL, url: station.streamURL);

    await player.play();
  }
}
