import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radiov3/apis/radio_api.dart';
import 'package:radiov3/apis/shared_prefers_api.dart';
import 'package:radiov3/providers/radio_provider.dart';
import 'package:radiov3/utils/radiostation.dart';
import 'package:radiov3/models/radio_station.dart';

class RadioList extends StatelessWidget {
  const RadioList({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RadioProvider>(context, listen: false);
    return ListView.builder(
      itemCount: RadioStations.allstations.length,
      itemBuilder: (context, index) {
        final station = RadioStations.allstations[index];
        return ListTile(
          leading: Image.network(station.photoURL,
              width: 50, height: 50, fit: BoxFit.cover),
          horizontalTitleGap: 50,
          title: Text(station.nameURL),
          onTap: () async {
            provider.setRadioStation(station);
            SharedPrefApi.setStation(station);
            await RadioApi.changeStation(station);
          },
        );
      },
    );
  }
}
