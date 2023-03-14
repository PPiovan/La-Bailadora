import 'package:flutter/material.dart';
import 'package:radiov3/Screens/home_screen.dart';
import 'package:radiov3/models/radio_station.dart';
import 'package:radiov3/providers/radio_provider.dart';
import 'apis/shared_prefers_api.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final radioStation = await SharedPrefApi.getInitalRadioStation();
  runApp(
    MyApp(initialStation: radioStation),
  );
}

class MyApp extends StatelessWidget {
  final RadioStation initialStation;

  const MyApp({required this.initialStation, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => RadioProvider(initialStation)),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FM Bailadora',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: HomeScreen(),
      ),
    );
  }
}
