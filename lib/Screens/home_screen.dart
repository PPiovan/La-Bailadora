import 'package:flutter/material.dart';
import 'package:radiov3/Widgets/gradient_background.dart';
import 'package:radiov3/Widgets/radio_player.dart';
import 'package:radiov3/apis/radio_api.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: FutureBuilder(
            future: RadioApi.initPlayer(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.white,
                ));
              }
              return const RadioPlayer();
            }),
      ),
    );
  }
}
