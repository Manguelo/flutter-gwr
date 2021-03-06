import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gwr/app_config.dart';
import 'package:flutter_gwr/screens/home_page.dart';
import 'package:flutter_gwr/stores/root_store.dart';
import 'package:flutter_gwr/theme.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  final configuredApp = AppConfig(
    rootStore: RootStore(),
    child: MyApp(),
  );

  runApp(configuredApp);
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainAppState();
}

class MainAppState extends State<MyApp> implements WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    AssetsAudioPlayer.setupNotificationsOpenAction((notification) {
      return true;
    });
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Database',
      debugShowCheckedModeBanner: false,
      theme: gwrTheme,
      home: HomePage(),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.resumed:
        break;
      default:
        break;
    }
  }

  @override
  void didChangeAccessibilityFeatures() {}

  @override
  void didChangeMetrics() {}

  @override
  void didChangePlatformBrightness() {}

  @override
  void didChangeTextScaleFactor() {}

  @override
  void didHaveMemoryPressure() {}

  @override
  Future<bool> didPopRoute() {
    throw UnimplementedError();
  }

  @override
  Future<bool> didPushRoute(String route) {
    throw UnimplementedError();
  }

  @override
  void didChangeLocales(List<Locale> locale) {}
}
