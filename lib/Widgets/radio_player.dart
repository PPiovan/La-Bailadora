import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radiov3/Widgets/radio_list.dart';
import 'package:radiov3/apis/radio_api.dart';
import 'package:radiov3/providers/radio_provider.dart';
import 'package:radiov3/utils/radiostation.dart';
import 'package:volume_controller/volume_controller.dart';

class RadioPlayer extends StatefulWidget {
  const RadioPlayer({super.key});

  @override
  State<RadioPlayer> createState() => _RadioPlayerState();

  void stop() {}

  setChannel({required String title, required String url}) {}

  play() {}
}

class _RadioPlayerState extends State<RadioPlayer>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> radioOffset;
  late Animation<Offset> radioListOffset;
  late VolumeController volumeController;

  bool listEnabled = false;
  bool isPlaying = true;
  bool isMuted = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    radioListOffset = Tween(
      begin: const Offset(0, 1.0),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));

    radioOffset = Tween(
      begin: const Offset(0, 0.3),
      end: Offset(0, 0.0),
    ).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));

    RadioApi.player.stateStream.listen((event) {
      setState(() {
        isPlaying = event;
      });
    });

    volumeController = VolumeController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: SlideTransition(
            position: radioOffset,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 250,
                  width: 300,
                  color: Colors.transparent,
                  child: Consumer<RadioProvider>(
                    builder: ((context, value, child) {
                      return Image.network(
                        value.station.photoURL,
                        fit: BoxFit.contain,
                      );
                    }),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            listEnabled = !listEnabled;
                          });
                          switch (animationController.status) {
                            case AnimationStatus.dismissed:
                              animationController.forward();
                              break;
                            case AnimationStatus.completed:
                              animationController.reverse();
                              break;
                            default:
                          }
                        },
                        color: listEnabled ? Colors.amber : Colors.black,
                        iconSize: 30,
                        icon: Icon(Icons.list_sharp)),
                    IconButton(
                        onPressed: () async {
                          isPlaying
                              ? RadioApi.player.stop()
                              : RadioApi.player.play();
                        },
                        color: Colors.red[700],
                        iconSize: 50,
                        icon: Icon(
                            isPlaying ? Icons.stop_circle : Icons.play_circle)),
                    IconButton(
                        onPressed: () async {
                          if (isMuted) {
                            volumeController.setVolume(0.5);
                          } else {
                            volumeController.muteVolume();
                          }
                          setState(() {
                            isMuted = !isMuted;
                          });
                        },
                        color: Colors.red[700],
                        iconSize: 50,
                        icon:
                            Icon(isMuted ? Icons.volume_off : Icons.volume_up)),
                  ],
                ),
              ],
            ),
          ),
        ),
        SlideTransition(
          position: radioListOffset,
          child: Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white54,
              borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
            ),
            child: Column(
              children: const [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: const Text(
                    'Lista de Radios',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Divider(
                  color: Colors.black,
                  indent: 30,
                  endIndent: 30,
                ),
                Expanded(child: RadioList())
              ],
            ),
          ),
        )
      ],
    );
  }
}
